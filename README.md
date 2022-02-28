# EQMonitor

スマートフォン上で強震モニターの情報をいい感じのUIで表示できるアプリ
(を目標に…)


## ※注意
GitHub上にあるコードのみではビルドできません。
以下がGitHub上にないコードです
```
android/app/google-services.json
lib/private/keys.dart #Twitter API Keyを格納
```
予定では、新規ビルドしたい場合はPRを送っていただければ自動的にビルドするようにします。
(↑これ不適切なコードを埋め込まれる可能性があるので保留中)


## Build Command
```bash
flutter build apk --release --obfuscate --split-debug-info=obfuscate
```

## Build Status

[![Codemagic build status](https://api.codemagic.io/apps/621bb2a4bc3d3d2156cab924/621bb2a4bc3d3d2156cab923/status_badge.svg)](https://codemagic.io/apps/621bb2a4bc3d3d2156cab924/621bb2a4bc3d3d2156cab923/latest_build)

