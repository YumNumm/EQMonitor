#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path

TOOL_DIR = Path(__file__).resolve().parent
SESSION_DIR = "store_screenshot"
READY_TIMEOUT_SECONDS = 600
POLL_SECONDS = 1
LOCK_SETTLE_SECONDS = 3
APP_KEYS_EXCLUDED = ("platforms", "capture", "experimental")
DEVICE_APPS = ("Simulator.app", "DeviceHub.app")


class CaptureError(RuntimeError):
    pass


def run(*args: str, capture: bool = False) -> str:
    result = subprocess.run(args, check=True, text=True, stdout=subprocess.PIPE if capture else None)
    return result.stdout.strip() if capture else ""


def select_scenes(config: dict, platform: str, names: set[str] | None) -> list[dict]:
    scenes = [scene for scene in config["scenes"] if platform in scene["platforms"]]
    if names is None:
        return [scene for scene in scenes if not scene.get("experimental", False)]
    unknown = names - {scene["name"] for scene in scenes}
    if unknown:
        raise CaptureError(f"unknown scenes for {platform}: {', '.join(sorted(unknown))}")
    return [scene for scene in scenes if scene["name"] in names]


def app_session(config: dict, scenes: list[dict]) -> dict:
    return {
        "preferences": config["preferences"],
        "scenes": [{key: value for key, value in scene.items() if key not in APP_KEYS_EXCLUDED} for scene in scenes],
    }


def drop_scenes_without_fixtures(scenes: list[dict], fixtures: Path, allow_missing: bool) -> list[dict]:
    missing = sorted({scene["fixture"] for scene in scenes if "fixture" in scene and not (fixtures / scene["fixture"]).is_file()})
    if not missing:
        return scenes
    if not allow_missing:
        raise CaptureError(f"missing fixtures in {fixtures}: {', '.join(missing)}")
    print(f"::warning::skipping scenes that need missing fixtures: {', '.join(missing)}")
    return [scene for scene in scenes if scene.get("fixture") not in missing]


def find_device_app() -> Path:
    # Xcode 27 では Simulator.app が DeviceHub.app に置き換わっている（2026-11-22 の runner で確認）。
    xcode = Path(run("xcode-select", "-p", capture=True)).parents[1]
    for name in DEVICE_APPS:
        found = run("find", str(xcode), "-maxdepth", "6", "-name", name, "-type", "d", capture=True)
        candidates = [Path(line) for line in found.splitlines()] + [Path("/Applications") / name]
        existing = next((path for path in candidates if path.is_dir()), None)
        if existing is not None:
            print(f"using {existing}")
            return existing
    apps = run("find", str(xcode / "Contents"), "-maxdepth", "4", "-name", "*.app", "-type", "d", capture=True)
    raise CaptureError(f"none of {', '.join(DEVICE_APPS)} was found. Apps in Xcode:\n{apps}")


class IosSimulator:
    def __init__(self, udid: str, bundle_id: str) -> None:
        self.udid = udid
        self.bundle_id = bundle_id
        self.root: Path | None = None

    def prepare(self, config: dict) -> None:
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

    def install(self, app: Path) -> None:
        run("xcrun", "simctl", "install", self.udid, str(app))
        run("xcrun", "simctl", "privacy", self.udid, "grant", "location-always", self.bundle_id)
        container = run("xcrun", "simctl", "get_app_container", self.udid, self.bundle_id, "data", capture=True)
        self.root = Path(container) / "Documents" / SESSION_DIR

    def session_path(self, relative: str) -> Path:
        if self.root is None:
            raise CaptureError("the app is not installed")
        return self.root / relative

    def reset(self) -> None:
        run("rm", "-rf", str(self.session_path("")))

    def put(self, relative: str, source: Path) -> None:
        destination = self.session_path(relative)
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source, destination)

    def exists(self, relative: str) -> bool:
        return self.session_path(relative).exists()

    def read_text(self, relative: str) -> str:
        return self.session_path(relative).read_text()

    def launch(self) -> None:
        run("xcrun", "simctl", "launch", "--terminate-running-process", self.udid, self.bundle_id)

    def app_log(self) -> str:
        # Flutter の print は stdout ではなく unified logging に出る。
        return run(
            "xcrun", "simctl", "spawn", self.udid, "log", "show", "--style", "compact", "--last", "30m",
            "--predicate", 'process == "Runner" AND eventMessage CONTAINS "flutter:"',
            capture=True,
        )

    def screenshot(self, destination: Path) -> None:
        run("xcrun", "simctl", "io", self.udid, "screenshot", "--type=png", str(destination))

    def lock(self) -> None:
        # simctl にロック操作が無いためデバイス表示アプリのメニューを操作する。runner に Accessibility 権限が必要。
        app = find_device_app()
        run("open", "-a", str(app), "--args", "-CurrentDeviceUDID", self.udid)
        time.sleep(LOCK_SETTLE_SECONDS)
        run(
            "osascript",
            "-e", f'tell application "{app.stem}" to activate',
            "-e", f'tell application "System Events" to tell process "{app.stem}" '
            'to click menu item "Lock" of menu "Device" of menu bar 1',
        )


class AndroidEmulator:
    def __init__(self, serial: str, package: str) -> None:
        self.serial = serial
        self.package = package
        self.status_bar_time = ""

    def adb(self, *args: str, capture: bool = False) -> str:
        return run("adb", "-s", self.serial, *args, capture=capture)

    def app_shell(self, command: str, capture: bool = False) -> str:
        return self.adb("shell", f"run-as {self.package} sh -c '{command}'", capture=capture)

    def prepare(self, config: dict) -> None:
        self.adb("wait-for-device")
        while self.adb("shell", "getprop", "sys.boot_completed", capture=True) != "1":
            time.sleep(POLL_SECONDS)
        self.status_bar_time = config["statusBarTime"].replace(":", "").zfill(4)
        self.adb("shell", "settings", "put", "global", "sysui_demo_allowed", "1")
        self.adb("shell", "cmd", "uimode", "night", "yes" if config["appearance"] == "dark" else "no")
        location = config["location"]
        self.adb("emu", "geo", "fix", str(location["longitude"]), str(location["latitude"]))

    def apply_demo_mode(self) -> None:
        for extras in (
            ["-e", "command", "enter"],
            ["-e", "command", "clock", "-e", "hhmm", self.status_bar_time],
            ["-e", "command", "battery", "-e", "level", "100", "-e", "plugged", "false"],
            ["-e", "command", "network", "-e", "wifi", "show", "-e", "level", "4", "-e", "fully", "true"],
            ["-e", "command", "notifications", "-e", "visible", "false"],
        ):
            self.adb("shell", "am", "broadcast", "-a", "com.android.systemui.demo", *extras)

    def install(self, app: Path) -> None:
        self.adb("install", "-r", "-g", str(app))

    def session_path(self, relative: str) -> str:
        return f"app_flutter/{SESSION_DIR}/{relative}".rstrip("/")

    def reset(self) -> None:
        self.app_shell(f"rm -rf {self.session_path('')}")

    def put(self, relative: str, source: Path) -> None:
        staging = f"/data/local/tmp/{SESSION_DIR}-upload"
        destination = self.session_path(relative)
        self.adb("push", str(source), staging)
        self.app_shell(f"mkdir -p $(dirname {destination}) && cp {staging} {destination}")
        self.adb("shell", "rm", "-f", staging)

    def exists(self, relative: str) -> bool:
        result = subprocess.run(
            ["adb", "-s", self.serial, "shell", f"run-as {self.package} test -e {self.session_path(relative)}"],
            check=False,
        )
        return result.returncode == 0

    def read_text(self, relative: str) -> str:
        return self.app_shell(f"cat {self.session_path(relative)}", capture=True)

    def launch(self) -> None:
        self.adb("logcat", "-c")
        self.adb("shell", "am", "force-stop", self.package)
        self.adb("shell", "monkey", "-p", self.package, "-c", "android.intent.category.LAUNCHER", "1")

    def app_log(self) -> str:
        return self.adb("logcat", "-d", "-s", "flutter:V", capture=True)

    def screenshot(self, destination: Path) -> None:
        # 起動直後や SystemUI の再起動で demo mode が外れるため、撮影ごとに適用し直す。
        self.apply_demo_mode()
        time.sleep(POLL_SECONDS)
        with destination.open("wb") as file:
            subprocess.run(["adb", "-s", self.serial, "exec-out", "screencap", "-p"], check=True, stdout=file)

    def lock(self) -> None:
        raise CaptureError("lock screen capture is only implemented for iOS")


def put_text(device: IosSimulator | AndroidEmulator, relative: str, text: str) -> None:
    with tempfile.NamedTemporaryFile("w", suffix=".json", delete=False) as file:
        file.write(text)
    try:
        device.put(relative, Path(file.name))
    finally:
        os.unlink(file.name)


def wait_for(device: IosSimulator | AndroidEmulator, relative: str) -> None:
    deadline = time.monotonic() + READY_TIMEOUT_SECONDS
    while time.monotonic() < deadline:
        if device.exists("failed"):
            raise CaptureError(f"the app reported a failure:\n{device.read_text('failed')}")
        if device.exists(relative):
            return
        time.sleep(POLL_SECONDS)
    raise CaptureError(f"timed out waiting for {relative}")


APP_ERROR_PATTERN = re.compile(r"http-error|DioException|Exception|FORBIDDEN|Status: [45]\d\d")
APP_ERROR_CONTEXT_LINES = 4
APP_ERROR_MAX_LINES = 120


def app_error_lines(log: str) -> list[str]:
    lines = log.splitlines()
    selected: set[int] = set()
    for index, line in enumerate(lines):
        if APP_ERROR_PATTERN.search(line):
            selected.update(range(index, min(index + APP_ERROR_CONTEXT_LINES + 1, len(lines))))
    return [lines[index] for index in sorted(selected)][-APP_ERROR_MAX_LINES:]


def report_app_errors(device: IosSimulator | AndroidEmulator) -> None:
    # 公開リポジトリの artifact に全文を残さないため、エラーに関係する行だけをジョブログへ出す。
    try:
        lines = app_error_lines(device.app_log())
    except subprocess.CalledProcessError as error:
        print(f"::warning::could not read the app log: {error}")
        return
    if lines:
        print("::group::app errors")
        print("\n".join(lines))
        print("::endgroup::")


def capture(device: IosSimulator | AndroidEmulator, config: dict, scenes: list[dict], app: Path, fixtures: Path, output: Path) -> None:
    device.prepare(config)
    device.install(app)
    device.reset()
    for fixture in sorted({scene["fixture"] for scene in scenes if "fixture" in scene}):
        device.put(f"fixtures/{fixture}", fixtures / fixture)
    put_text(device, "session.json", json.dumps(app_session(config, scenes), ensure_ascii=False))
    output.mkdir(parents=True, exist_ok=True)
    device.launch()
    try:
        capture_scenes(device, scenes, output)
    finally:
        report_app_errors(device)


def capture_scenes(device: IosSimulator | AndroidEmulator, scenes: list[dict], output: Path) -> None:
    for scene in scenes:
        try:
            wait_for(device, f"ready/{scene['name']}")
        except CaptureError:
            device.screenshot(output / f"failure-{scene['name']}.png")
            raise
        if scene.get("capture") == "lock_screen":
            device.lock()
            time.sleep(LOCK_SETTLE_SECONDS)
        destination = output / f"{scene['name']}.png"
        device.screenshot(destination)
        put_text(device, f"captured/{scene['name']}", "")
        print(f"captured: {destination}")
    wait_for(device, "done")


def runtime_version(runtime: dict) -> tuple[int, ...]:
    return tuple(int(part) for part in runtime["version"].split("."))


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
                print(f"created {name} on iOS {runtime['version']}")
                return result.stdout.strip()
            print(f"cannot create {name} on iOS {runtime['version']}: {result.stderr.strip()}")
    iphones = ", ".join(sorted(name for name in identifiers if name.startswith("iPhone")))
    versions = ", ".join(runtime["version"] for runtime in runtimes)
    raise CaptureError(
        f"none of {', '.join(device_types)} could be created. iPhone types: {iphones}. iOS runtimes: {versions}"
    )


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description="Capture store screenshot scenes on an iOS Simulator or Android Emulator")
    parser.add_argument("--platform", choices=("ios", "android"), required=True)
    parser.add_argument("--app", type=Path, required=True, help="Runner.app (iOS) or debug APK (Android)")
    parser.add_argument("--fixtures", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--config", type=Path, default=TOOL_DIR / "scenes.json")
    parser.add_argument("--device", help="simulator UDID or adb serial (default: create an iOS simulator / ANDROID_SERIAL)")
    parser.add_argument("--ios-device-type", action="append", default=[], help="preferred iOS device type, in order")
    parser.add_argument(
        "--scenes", help="comma separated scene names (default: every non-experimental scene for the platform)"
    )
    parser.add_argument("--allow-missing-fixtures", action="store_true")
    args = parser.parse_args(argv)

    config = json.loads(args.config.read_text())
    names = set(args.scenes.split(",")) if args.scenes else None
    scenes = drop_scenes_without_fixtures(
        select_scenes(config, args.platform, names), args.fixtures, args.allow_missing_fixtures
    )
    if not scenes:
        raise CaptureError("no scenes to capture")
    if args.platform == "ios":
        udid = args.device or create_ios_simulator(args.ios_device_type or ["iPhone 18 Pro", "iPhone 17 Pro"])
        device: IosSimulator | AndroidEmulator = IosSimulator(udid, config["applicationId"])
    else:
        serial = args.device or os.environ.get("ANDROID_SERIAL", "emulator-5554")
        device = AndroidEmulator(serial, config["applicationId"])
    capture(device, config, scenes, args.app, args.fixtures, args.output)
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except (CaptureError, subprocess.CalledProcessError) as error:
        print(f"error: {error}", file=sys.stderr)
        sys.exit(1)
