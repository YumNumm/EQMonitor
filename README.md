# eqmonitor

Earth Quake Monitor Application

## Build Command
```bash
# Dev release
flutter build apk --release --flavor dev --dart-define=FLAVOR=dev --obfuscate --split-debug-info=obfuscate -t .\lib\main-dev.dart -v
# Prod release
flutter build apk --release --flavor prod --dart-define=FLAVOR=prod --obfuscate --split-debug-info=obfuscate -t .\lib\main-prod.dart -v
```

## Build Status

[![Codemagic build status](https://api.codemagic.io/apps/62066402cb455d66b1f50eb5/62066402cb455d66b1f50eb4/status_badge.svg)](https://codemagic.io/apps/62066402cb455d66b1f50eb5/62066402cb455d66b1f50eb4/latest_build)

## TODO

- [ ] iOS <https://blog.codemagic.io/practical-guide-flutter-firebase-codemagic/>

## Hive Memo

- `10` NotificationSettings


```json
 {'type': 'intensity_report', 'time': '1645289350954', 'max_index': 0, 'intensity_list': [{'intensity': '0', 'index': 0, 'region_list': ['根室']}]}
```