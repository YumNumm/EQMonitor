# EQMonitor

## 地震速報・監視アプリケーション

[![Github All Releases](https://img.shields.io/github/downloads/EQMonitor/EQMonitor/total.svg)](https://github.com/EQMonitor/EQMonitor/tags)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/EQMonitor/EQMonitor?color=blue&include_prereleases&label=Release)](https://github.com/EQMonitor/EQMonitor/releases/latest)

|                                                                                    Android                                                                                     |                                                                                                iOS                                                                                                |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| [<img src="https://github.com/YumNumm/YumNumm/raw/main/resources/img/google-play-badge.png" height="50">](https://play.google.com/store/apps/details?id=net.yumnumm.eqmonitor) | [<img src="https://github.com/YumNumm/YumNumm/raw/main/resources/img/appstore-badge.png" height="50">](https://apps.apple.com/ja/app/eqmonitor-%E5%9C%B0%E9%9C%87%E9%80%9F%E5%A0%B1/id6447546703) |

> [!WARNING]
> [利用規約 - Term of Service](https://github.com/EQMonitor/EQMonitor/blob/main/assets/docs/term_of_service.md)を必ずご確認の上ご利用ください。

![iPad1](https://github.com/YumNumm/EQMonitor/assets/73390859/27077058-397d-4f87-9adf-a4a9797b2605)


## 概要

EQMonitorは、日本全国の地震情報をいち早く受信できるアプリケーションです。

**_機能_**

- **地震情報・緊急地震速報の通知**

  気象庁により発表された地震情報や、緊急地震速報を受信し、通知します。

- **過去の地震履歴の閲覧**

  過去に発表された地震情報を遡って確認できます。

- **緊急地震速報のリアルタイム表示**

  緊急地震速報が発表された際に、P波・S波の予想到達範囲、予想最大震度、震央地を表示します。
  緊急地震速報は、リアルタイムに更新され、インターネットに接続されていれば、どこからでも確認できます。

- **強震モニタの表示**

  防災科学技術研究所の提供するWebサービス 強震モニタ を表示します。
  (※ 強震モニタは、揺れの様子を直感的に捉えることを目的としています。また、リアルタイムで観測値を処理しているため、ノイズ等により観測値が変動します。
  そのため、本アプリケーションで表示される観測値は、あくまで参考値としてご利用ください。)

## 環境構築

下記のコマンドをターミナルから実行してください。

1. `git clone https://github.com/YumNumm/EQMonitor` でリポジトリをクローンします。

1. `cd EQMonitor` でカレントディレクトリを移動します。

1. Dartプロジェクトを管理するためのツールである[melos](https://melos.invertase.dev/)をインストールします。

   - `dart pub global activate melos` を実行してください。
   - 詳細は、[Get Started](https://melos.invertase.dev/~melos-latest/getting-started)を参照してください。

1. `melos bootstrap` を実行してください。

   - これにより、各パッケージの依存関係が解決されます。

1. `mv app/.env.example app/.env` を実行してください。

   - HTTP APIのみ Staging APIへ接続できます。(事前設定済み)
     - 常に最新の地震情報が提供されることを保証しません。
     - 事前の予告なしに、APIの仕様が変更される可能性があります。
     - アプリストアで公開しているAPIとは異なり、APIの実行環境やWAFの設定が異なります。
   - その他の値は、そのままでも問題ありません。
     - WebSocket APIは公開していないため、リアルタイムでの緊急地震速報の受信などはできません。

1. `fvm flutter run` でアプリケーションを起動します。
