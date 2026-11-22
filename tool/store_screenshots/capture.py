#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import time
from pathlib import Path

TOOL_DIR = Path(__file__).resolve().parent
APP_DIR = TOOL_DIR.parent.parent / "app"
PATROL_TARGET = "patrol_test/store_screenshots_test.dart"
SESSION_DIR = "store_screenshot"
POLL_SECONDS = 1


class CaptureError(RuntimeError):
    pass


def run(*args: str, capture: bool = False) -> str:
    result = subprocess.run(args, check=True, text=True, stdout=subprocess.PIPE if capture else None)
    return result.stdout.strip() if capture else ""


class IosSimulator:
    def __init__(self, udid: str, bundle_id: str) -> None:
        self.udid = udid
        self.bundle_id = bundle_id

    @property
    def patrol_device(self) -> str:
        return self.udid

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

    def session_root(self) -> Path | None:
        result = subprocess.run(
            ["xcrun", "simctl", "get_app_container", self.udid, self.bundle_id, "data"],
            check=False, text=True, capture_output=True,
        )
        return Path(result.stdout.strip()) / "Documents" / SESSION_DIR if result.returncode == 0 else None

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

    def screenshot(self, destination: Path) -> None:
        run("xcrun", "simctl", "io", self.udid, "screenshot", "--type=png", str(destination))


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
    output.mkdir(parents=True, exist_ok=True)
    command = ["patrol", "test", "--target", PATROL_TARGET, "--device", device.patrol_device, *patrol_args]
    print(f"running: {' '.join(command)}", flush=True)
    patrol = subprocess.Popen(command, cwd=APP_DIR)
    captured: set[str] = set()
    try:
        while patrol.poll() is None:
            for scene in pending_scenes(device.list_markers("ready"), captured):
                destination = output / f"{scene}.png"
                device.screenshot(destination)
                device.write_marker(f"captured/{scene}")
                captured.add(scene)
                print(f"captured: {destination}", flush=True)
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
                return result.stdout.strip()
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
    parser.add_argument("--ios-device-type", action="append", default=[], help="preferred iOS device type, in order")
    parser.add_argument("patrol_args", nargs=argparse.REMAINDER)
    args = parser.parse_args(argv)
    patrol_args = args.patrol_args[1:] if args.patrol_args[:1] == ["--"] else args.patrol_args

    config = json.loads(args.config.read_text())
    if args.platform == "ios":
        udid = args.device or create_ios_simulator(args.ios_device_type or ["iPhone 18 Pro", "iPhone 17 Pro"])
        device: IosSimulator | AndroidEmulator = IosSimulator(udid, config["applicationId"])
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
