# EQMonitor

### 地震速報・監視アプリケーション

[![45BD36DF-05A4-4875-B913-2F53FDAA48FF](https://user-images.githubusercontent.com/73390859/183258345-ac71c9ca-b794-4c00-bd7d-a9a20693464e.png)](https://github.com/EQMonitor/EQMonitor)

[![Github All Releases](https://img.shields.io/github/downloads/EQMonitor/EQMonitor/total.svg)](https://github.com/EQMonitor/EQMonitor/tags)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/EQMonitor/EQMonitor?color=blue&include_prereleases&label=Release)](https://github.com/EQMonitor/EQMonitor/releases/latest)
[![Flutter build Android](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml/badge.svg)](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml)

> **Warning** [利用規約](https://github.com/EQMonitor/EQMonitor/blob/main/assets/docs/term_of_service.md)を必ずご確認の上ご利用ください。

|                                                                                                                                                |                                                                                                                                                |                                                                                                                                                |
|------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| ![Screenshot_20221114-171045_EQMonitor](https://user-images.githubusercontent.com/73390859/201656094-c98e6942-489d-48dc-9ff5-80aa6d9e6247.png) | ![Screenshot_20221114-210650_EQMonitor](https://user-images.githubusercontent.com/73390859/201656208-87ae0eed-bf39-47d4-8003-9745ffba56c2.png) | ![Screenshot_20221114-210658_EQMonitor](https://user-images.githubusercontent.com/73390859/201656236-70d20f7c-6870-4d0f-a7d0-17777e6b276b.png) |

## 支援のお願い

本アプリケーションは、緊急地震速報などの地震情報を迅速に配信するために、外部サービス([Project DM-D.S.S](https://dmdata.jp/))や VPS を契約しています。
そのため、開発者([@YumNumm](https://github.com/YumNumm))は、月数千円負担する必要があります。
ご支援頂けると幸いです。
**(本アプリは無料でご利用いただけます。)**

[![](https://user-images.githubusercontent.com/73390859/201659680-63768eda-b774-4709-9c89-0e71771f6135.jpeg)](https://www.buymeacoffee.com/mgmg)

## HOW TO BUILD

`android/app/google-service.json`に Firebase 証明書を配置してください。

```bash
# リポジトリをクローン
git clone https://github.com/YumNumm/EQMonitor.git
cd EQMonitor

# FVMをインストール
brew tap leoafarias/fvm
brew install fvm
fvm use


# Lefthookをインストール(コミット時にフォーマットを実行するため)
brew install lefthook
lefthook install

# パッケージをインストール
fvm flutter pub get
```
