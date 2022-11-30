# EQMonitor
### 地震速報・監視アプリケーション

[![45BD36DF-05A4-4875-B913-2F53FDAA48FF](https://user-images.githubusercontent.com/73390859/183258345-ac71c9ca-b794-4c00-bd7d-a9a20693464e.png)](https://github.com/EQMonitor/EQMonitor)

[![Github All Releases](https://img.shields.io/github/downloads/EQMonitor/EQMonitor/total.svg)](https://github.com/EQMonitor/EQMonitor/tags)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/EQMonitor/EQMonitor?color=blue&include_prereleases&label=Release)](https://github.com/EQMonitor/EQMonitor/releases/latest)
[![Flutter build Android](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml/badge.svg)](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml)

> **Warning**  [利用規約](https://github.com/EQMonitor/EQMonitor/blob/main/assets/docs/term_of_service.md)を必ずご確認の上ご利用ください。


||||
|---|---|---|
|![Screenshot_20221130-140611_EQMonitor](https://user-images.githubusercontent.com/73390859/204713006-ee9d8813-39f0-4a0f-81c4-61119dfd2199.png)|![Screenshot_20221114-210650_EQMonitor](https://user-images.githubusercontent.com/73390859/201656208-87ae0eed-bf39-47d4-8003-9745ffba56c2.png)|![Screenshot_20221130-141133_EQMonitor](https://user-images.githubusercontent.com/73390859/204712931-6bd899e9-f99b-466c-8b20-c4eecd5ff0b4.png)|


## 支援のお願い
本アプリケーションは、緊急地震速報などの地震情報を迅速に配信するために、外部サービス([Project DM-D.S.S](https://dmdata.jp/))やVPSを契約しています。  
そのため、開発者([@YumNumm](https://github.com/YumNumm))は、月数千円負担する必要があります。  
ご支援頂けると幸いです。  
**(本アプリは無料でご利用いただけます。)**  

[![](https://user-images.githubusercontent.com/73390859/201659680-63768eda-b774-4709-9c89-0e71771f6135.jpeg)](https://www.buymeacoffee.com/mgmg)





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
