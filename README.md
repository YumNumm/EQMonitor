# EQMonitor
### 地震速報・監視アプリケーション

[![45BD36DF-05A4-4875-B913-2F53FDAA48FF](https://user-images.githubusercontent.com/73390859/183258345-ac71c9ca-b794-4c00-bd7d-a9a20693464e.png)](https://github.com/EQMonitor/EQMonitor)

[![Github All Releases](https://img.shields.io/github/downloads/EQMonitor/EQMonitor/total.svg)](https://github.com/EQMonitor/EQMonitor/tags)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/EQMonitor/EQMonitor?color=blue&include_prereleases&label=Release)](https://github.com/EQMonitor/EQMonitor/releases/latest)
[![Flutter build Android](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml/badge.svg)](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml)

> **Warning**  [利用規約](https://github.com/EQMonitor/EQMonitor/blob/main/assets/docs/term_of_service.md)を必ずご確認の上ご利用ください。

## 支援のお願い
本アプリケーションは、緊急地震速報などの地震情報を迅速に配信するために、外部サービス([Project DM-D.S.S](https://dmdata.jp/))に契約し、VPSに契約しています。  
そのため、開発者([@YumNumm](https://github.com/YumNumm))は、月数千円負担する必要があります。  
ご支援頂けると幸いです。  
**(本アプリは無料でご利用いただけます。)**  
<a href="https://www.buymeacoffee.com/OnoueRyotaro" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>




## HOW TO BUILD

`android/app/google-service.json`にFirebase証明書を配置してください。

```bash
git clone https://github.com/EQMonitor/EQMonitor.git --depth 1 
cd EQMonitor
mv .env.example .env

# FVM未導入の場合
dart pub global activate fvm

fvm use # yesと入力
fvm flutter pub get
fvm flutter pub run build_runner build -d
fvm flutter pub run flutter_launcher_icons:main
fvm flutter pub run flutter_native_splash:create

# RELEASE BUILD
flutter build apk --release

# DEBUG BUILD
flutter build apk --debug
```
