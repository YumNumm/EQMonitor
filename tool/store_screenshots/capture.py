#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

TOOL_DIR = Path(__file__).resolve().parent
APP_DIR = TOOL_DIR.parent.parent / "app"
PATROL_TARGET = "patrol_test/store_screenshots_test.dart"
SESSION_DIR = "store_screenshot"
POLL_SECONDS = 1
# 続けて送ると到着順が入れ替わることがある。バナーが出きるのも待つ。
PUSH_INTERVAL_SECONDS = 1.5
# 通知を送るだけで撮らない合図。
NOTIFY_SUFFIX = "_notify"
WATCH_PREPARE_SCENE = "watch_live_activity_prepare"
WATCH_SYNC_TIMEOUT_SECONDS = 600
# 届いた直後はスマートスタックの並べ替えのアニメーションが残る。
WATCH_SETTLE_SECONDS = 3


class CaptureError(RuntimeError):
    pass


def run(*args: str, capture: bool = False) -> str:
    result = subprocess.run(args, check=True, text=True, stdout=subprocess.PIPE if capture else None)
    return result.stdout.strip() if capture else ""


class IosSimulator:
    def __init__(
        self,
        udid: str,
        bundle_id: str,
        wallpaper: Path | None = None,
        watch_udid: str | None = None,
        display: str | None = None,
    ) -> None:
        self.udid = udid
        self.bundle_id = bundle_id
        self.wallpaper = wallpaper
        self.watch_udid = watch_udid
        self.display = display
        self.container: Path | None = None

    @property
    def patrol_device(self) -> str:
        return self.udid

    def prepare(self, config: dict) -> None:
        configure_simulator(self.udid, config)
        if self.wallpaper is not None:
            # 非公開の保存形式に依存するため、ランタイムが変わると失敗しうる。壁紙なしで撮影を続ける。
            result = subprocess.run([str(TOOL_DIR / "set_ios_wallpaper.sh"), self.udid, str(self.wallpaper)], check=False)
            if result.returncode != 0:
                print("warning: could not set the wallpaper", flush=True)
            run("xcrun", "simctl", "bootstatus", self.udid, "-b")
        run("xcrun", "simctl", "ui", self.udid, "appearance", config["appearance"])
        run(
            "xcrun", "simctl", "status_bar", self.udid, "override",
            "--time", config["statusBarTime"],
            "--dataNetwork", "wifi", "--wifiMode", "active", "--wifiBars", "3",
            "--cellularMode", "active", "--cellularBars", "4", "--operatorName", "",
            "--batteryState", "charged", "--batteryLevel", "100",
        )
        location = config["location"]
        run("xcrun", "simctl", "location", self.udid, "set", f"{location['latitude']},{location['longitude']}")

    def session_root(self) -> Path | None:
        # 高負荷の runner では simctl の 1 回の呼び出しに数十秒かかったため、ポーリングごとに呼ばない。
        if self.container is None or not self.container.is_dir():
            result = subprocess.run(
                ["xcrun", "simctl", "get_app_container", self.udid, self.bundle_id, "data"],
                check=False, text=True, capture_output=True,
            )
            self.container = Path(result.stdout.strip()) if result.returncode == 0 else None
        return self.container / "Documents" / SESSION_DIR if self.container else None

    def clear_markers(self) -> None:
        root = self.session_root()
        if root is not None and root.is_dir():
            shutil.rmtree(root)
        self.container = None

    def list_markers(self, directory: str) -> set[str]:
        root = self.session_root()
        if root is None or not (root / directory).is_dir():
            return set()
        return {path.name for path in (root / directory).iterdir() if not path.name.endswith(".tmp")}

    def write_marker(self, relative: str) -> None:
        root = self.session_root()
        if root is None:
            raise CaptureError("the app container is gone")
        (root / relative).parent.mkdir(parents=True, exist_ok=True)
        (root / relative).touch()

    def push(self, payload: Path) -> None:
        run("xcrun", "simctl", "push", self.udid, self.bundle_id, str(payload))

    def watch_xcodebuild(self, action: str, derived_data: Path) -> None:
        if self.watch_udid is None:
            raise CaptureError("the test asked for the watch, but --watch-device is not set")
        run(
            "xcodebuild", action, "-quiet",
            "-project", str(TOOL_DIR / "watch_ui_tests" / "WatchUITests.xcodeproj"),
            "-scheme", "WatchUITests",
            "-destination", f"platform=watchOS Simulator,id={self.watch_udid}",
            "-derivedDataPath", str(derived_data),
            "CODE_SIGNING_ALLOWED=NO",
        )

    def prepare_watch(self, derived_data: Path) -> None:
        # 撮影時の所要時間を揃えるため、ビルドは先に済ませる。Live Activity の到達までの秒数がこの時間に依存する。
        run("xcrun", "simctl", "bootstatus", self.watch_udid, "-b")
        self.watch_xcodebuild("build-for-testing", derived_data)

    def wait_for_watch_log(self, started: str, predicate: str, expected: str, description: str) -> None:
        deadline = time.monotonic() + WATCH_SYNC_TIMEOUT_SECONDS
        while time.monotonic() < deadline:
            result = subprocess.run(
                [
                    "xcrun", "simctl", "spawn", self.watch_udid, "log", "show", "--start", started,
                    "--style", "compact", "--predicate", predicate,
                ],
                check=False, text=True, capture_output=True,
            )
            if expected in result.stdout:
                return
            time.sleep(POLL_SECONDS * 2)
        raise CaptureError(f"{description} did not reach the watch")

    # iPhone の Live Activity が Watch に届くまでの時間は数秒〜数分とばらつく。ログで確かめてから進む。
    def open_watch_smart_stack(self, derived_data: Path) -> None:
        # スマートスタックを開いている間に届くことがあるため、開く前の時刻からログを見る。
        started = time.strftime("%Y-%m-%d %H:%M:%S")
        self.watch_xcodebuild("test-without-building", derived_data)
        self.wait_for_watch_log(
            started,
            'process == "Carousel" AND eventMessage CONTAINS "received live activity element"',
            self.bundle_id,
            "the Live Activity",
        )
        time.sleep(WATCH_SETTLE_SECONDS)

    def watch_screenshot(self, destination: Path) -> None:
        if self.watch_udid is None:
            raise CaptureError("the test asked for the watch, but --watch-device is not set")
        run("xcrun", "simctl", "io", self.watch_udid, "screenshot", "--type=png", str(destination))

    def screenshot(self, destination: Path) -> None:
        display = [f"--display={self.display}"] if self.display else []
        run("xcrun", "simctl", "io", self.udid, "screenshot", "--type=png", *display, str(destination))


class AndroidEmulator:
    def __init__(self, serial: str, package: str) -> None:
        self.serial = serial
        self.package = package
        self.status_bar_time = ""

    @property
    def patrol_device(self) -> str:
        return self.serial

    def adb(self, *args: str, capture: bool = False) -> str:
        return run("adb", "-s", self.serial, *args, capture=capture)

    def app_shell(self, command: str) -> subprocess.CompletedProcess[str]:
        return subprocess.run(
            ["adb", "-s", self.serial, "shell", f"run-as {self.package} sh -c '{command}'"],
            check=False, text=True, capture_output=True,
        )

    def prepare(self, config: dict) -> None:
        self.adb("wait-for-device")
        while self.adb("shell", "getprop", "sys.boot_completed", capture=True) != "1":
            time.sleep(POLL_SECONDS)
        self.status_bar_time = config["statusBarTime"].replace(":", "").zfill(4)
        self.adb("shell", "cmd", "uimode", "night", "yes" if config["appearance"] == "dark" else "no")
        location = config["location"]
        self.adb("emu", "geo", "fix", str(location["longitude"]), str(location["latitude"]))

    def apply_demo_mode(self) -> None:
        self.adb("shell", "settings", "put", "global", "sysui_demo_allowed", "1")
        allowed = self.adb("shell", "settings", "get", "global", "sysui_demo_allowed", capture=True)
        print(f"sysui_demo_allowed={allowed}", flush=True)
        for extras in (
            ["-e", "command", "enter"],
            ["-e", "command", "clock", "-e", "hhmm", self.status_bar_time],
            ["-e", "command", "battery", "-e", "level", "100", "-e", "plugged", "false"],
            ["-e", "command", "network", "-e", "wifi", "show", "-e", "level", "4", "-e", "fully", "true"],
            ["-e", "command", "notifications", "-e", "visible", "false"],
        ):
            self.adb("shell", "am", "broadcast", "-a", "com.android.systemui.demo", *extras)

    def clear_markers(self) -> None:
        self.app_shell(f"rm -rf app_flutter/{SESSION_DIR}")

    def list_markers(self, directory: str) -> set[str]:
        result = self.app_shell(f"ls app_flutter/{SESSION_DIR}/{directory}")
        if result.returncode != 0:
            return set()
        return {name for name in result.stdout.split() if not name.endswith(".tmp")}

    def write_marker(self, relative: str) -> None:
        path = f"app_flutter/{SESSION_DIR}/{relative}"
        result = self.app_shell(f"mkdir -p $(dirname {path}) && touch {path}")
        if result.returncode != 0:
            raise CaptureError(f"could not write {path}: {result.stderr}")

    def push(self, payload: Path) -> None:
        raise CaptureError("push notifications are only supported on the iOS simulator")

    def screenshot(self, destination: Path) -> None:
        # 起動直後や SystemUI の再起動で demo mode が外れるため、撮影ごとに適用し直す。
        self.apply_demo_mode()
        time.sleep(POLL_SECONDS)
        with destination.open("wb") as file:
            subprocess.run(["adb", "-s", self.serial, "exec-out", "screencap", "-p"], check=True, stdout=file)


def pending_scenes(ready: set[str], captured: set[str]) -> list[str]:
    return sorted(ready - captured)


def capture(device: IosSimulator | AndroidEmulator, config: dict, patrol_args: list[str], output: Path) -> None:
    device.prepare(config)
    # 中断した前回の実行でアプリが残っていると、古い ready をビルド中に撮ってしまう。
    device.clear_markers()
    if isinstance(device, IosSimulator) and device.watch_udid is not None:
        device.prepare_watch(output.parent / "watch-derived-data")
    output.mkdir(parents=True, exist_ok=True)
    command = ["patrol", "test", "--target", PATROL_TARGET, "--device", device.patrol_device, "--no-label", *patrol_args]
    print(f"running: {' '.join(command)}", flush=True)
    environment = dict(os.environ)
    if isinstance(device, IosSimulator):
        environment["XCODE_XCCONFIG_FILE"] = str(TOOL_DIR / "ios_simulator.xcconfig")
    patrol = subprocess.Popen(command, cwd=APP_DIR, env=environment)
    captured: set[str] = set()
    try:
        while patrol.poll() is None:
            for scene in pending_scenes(device.list_markers("ready"), captured):
                started = time.monotonic()
                print(f"ready: {scene}", flush=True)
                destination = output / f"{scene}.png"
                pushes = config.get("push", {}).get(scene, [])
                for name in pushes:
                    device.push(TOOL_DIR / "push" / f"{name}.json")
                    time.sleep(PUSH_INTERVAL_SECONDS)
                watch_scene = config.get("watch", {}).get(scene)
                if scene == WATCH_PREPARE_SCENE:
                    device.open_watch_smart_stack(output.parent / "watch-derived-data")
                elif scene.endswith(NOTIFY_SUFFIX):
                    pass
                else:
                    device.screenshot(destination)
                if watch_scene and isinstance(device, IosSimulator) and device.watch_udid:
                    device.watch_screenshot(output / f"{watch_scene}.png")
                device.write_marker(f"captured/{scene}")
                captured.add(scene)
                print(f"captured: {destination} ({time.monotonic() - started:.1f}s)", flush=True)
            time.sleep(POLL_SECONDS)
    except BaseException:
        patrol.kill()
        raise
    if patrol.returncode != 0:
        device.screenshot(output / "failure.png")
        raise CaptureError(f"patrol test exited with {patrol.returncode}")
    if not captured:
        raise CaptureError("patrol test finished without capturing any scene")


def runtime_version(runtime: dict) -> tuple[int, ...]:
    return tuple(int(part) for part in runtime["version"].split("."))


def read_default(udid: str, domain: str, key: str) -> str:
    result = subprocess.run(
        ["xcrun", "simctl", "spawn", udid, "defaults", "read", domain, key],
        check=False, text=True, capture_output=True,
    )
    return result.stdout.strip() if result.returncode == 0 else ""


def configure_simulator(udid: str, config: dict) -> None:
    run("xcrun", "simctl", "bootstatus", udid, "-b")
    changed = False
    # 新規の Simulator は host の言語を引き継ぐ。テストはシステムダイアログを日本語のラベルで探す。
    if '"ja-JP"' not in read_default(udid, "-g", "AppleLanguages").split(",")[0]:
        run("xcrun", "simctl", "spawn", udid, "defaults", "write", "-g", "AppleLanguages", "-array", "ja-JP")
        run("xcrun", "simctl", "spawn", udid, "defaults", "write", "-g", "AppleLocale", "ja_JP")
        changed = True
    # Device Hub の「Liquid Glass」のスライダーが書く値。1 が最も不透明。
    tint = config.get("liquidGlassTintAmount")
    if tint is not None and read_default(udid, "com.apple.UIKit", "UIViewGlassTintAmount") != f"{tint:g}":
        run(
            "xcrun", "simctl", "spawn", udid, "defaults", "write",
            "com.apple.UIKit", "UIViewGlassTintAmount", "-float", str(tint),
        )
        changed = True
    if changed:
        run("xcrun", "simctl", "shutdown", udid)
        run("xcrun", "simctl", "bootstatus", udid, "-b")


def create_ios_simulator(device_types: list[str]) -> str:
    listing = json.loads(run("xcrun", "simctl", "list", "--json", "devicetypes", "runtimes", capture=True))
    identifiers = {device["name"]: device["identifier"] for device in listing["devicetypes"]}
    runtimes = sorted(
        (runtime for runtime in listing["runtimes"] if runtime.get("platform") == "iOS" and runtime.get("isAvailable")),
        key=runtime_version,
        reverse=True,
    )
    for runtime in runtimes:
        for name in (candidate for candidate in device_types if candidate in identifiers):
            result = subprocess.run(
                ["xcrun", "simctl", "create", f"EQMonitor Store Screenshot ({name})", identifiers[name], runtime["identifier"]],
                check=False,
                text=True,
                capture_output=True,
            )
            if result.returncode == 0:
                print(f"created {name} on iOS {runtime['version']}", flush=True)
                udid = result.stdout.strip()
                return udid
            print(f"cannot create {name} on iOS {runtime['version']}: {result.stderr.strip()}", flush=True)
    iphones = ", ".join(sorted(name for name in identifiers if name.startswith("iPhone")))
    versions = ", ".join(runtime["version"] for runtime in runtimes)
    raise CaptureError(
        f"none of {', '.join(device_types)} could be created. iPhone types: {iphones}. iOS runtimes: {versions}"
    )


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(
        description="Run the Patrol store screenshot test and capture each scene from the host",
        epilog="Arguments after -- are passed to `patrol test`.",
    )
    parser.add_argument("--platform", choices=("ios", "android"), required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--config", type=Path, default=TOOL_DIR / "device.json")
    parser.add_argument("--device", help="simulator UDID or adb serial (default: create an iOS simulator / ANDROID_SERIAL)")
    parser.add_argument("--wallpaper", type=Path, help="image to set as the iOS simulator wallpaper (skipped when the file is missing)")
    parser.add_argument(
        "--ios-display",
        help="simctl screen to capture, e.g. primary-1 for the inner display of iPhone Duo (see simctl io <udid> enumerate)",
    )
    parser.add_argument("--watch-device", help="paired watch simulator UDID; captures the Live Activity in its Smart Stack")
    parser.add_argument("--ios-device-type", action="append", default=[], help="preferred iOS device type, in order")
    parser.add_argument("patrol_args", nargs=argparse.REMAINDER)
    args = parser.parse_args(argv)
    patrol_args = args.patrol_args[1:] if args.patrol_args[:1] == ["--"] else args.patrol_args

    config = json.loads(args.config.read_text())
    if args.platform == "ios":
        udid = args.device or create_ios_simulator(args.ios_device_type or ["iPhone 18 Pro", "iPhone 17 Pro"])
        device: IosSimulator | AndroidEmulator = IosSimulator(
            udid,
            config["applicationId"],
            args.wallpaper if args.wallpaper and args.wallpaper.is_file() else None,
            args.watch_device,
            args.ios_display,
        )
    else:
        serial = args.device or os.environ.get("ANDROID_SERIAL", "emulator-5554")
        device = AndroidEmulator(serial, config["applicationId"])
    capture(device, config, patrol_args, args.output)
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except (CaptureError, subprocess.CalledProcessError) as error:
        print(f"error: {error}", file=sys.stderr)
        sys.exit(1)
