# EQMonitor

[![45BD36DF-05A4-4875-B913-2F53FDAA48FF](https://user-images.githubusercontent.com/73390859/183258345-ac71c9ca-b794-4c00-bd7d-a9a20693464e.png)](https://github.com/EQMonitor/EQMonitor)

[![Github All Releases](https://img.shields.io/github/downloads/EQMonitor/EQMonitor/total.svg)](https://github.com/EQMonitor/EQMonitor/tags)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/EQMonitor/EQMonitor?color=blue&include_prereleases&label=Release)](https://github.com/EQMonitor/EQMonitor/releases/latest)
[![Flutter build Android](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml/badge.svg)](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml)

> **Warning**  [利用規約](https://github.com/EQMonitor/EQMonitor/blob/main/assets/docs/term_of_service.md)を必ずご確認の上ご利用ください。

## 機能

- [x] 緊急地震速報などの地震情報の通知
- [x] 強震モニタの表示
- [x] 緊急地震速報の情報をマップ上に表示
- [x] 地震履歴
- [x] 距離減衰式による震度推定(緊急地震速報発表時を除く)
- [ ] 地震情報の読み上げ(バックグラウンド/フォアグラウンド)

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=642cebc69a3e&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

## HOW TO BUILD

`android/app/google-service.json`,`lib/private/keys.dart`を追加する必要があります。
`google-service.json`は、FirebaseのAndroid Key
`keys.dart`は様々なAPIKeyが格納されています(`lib/private/keys.sample.dart`をご覧ください)

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run flutter_launcher_icons:main
flutter pub run flutter_native_splash:create
# RELEASE BUILD
flutter build apk --release --obfuscate --split-debug-info=obfuscate/android
# DEBUG BUILD
flutter build apk --debug
```
