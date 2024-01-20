# EQMonitor

## 地震速報・監視アプリケーション

[![45BD36DF-05A4-4875-B913-2F53FDAA48FF](https://github.com/YumNumm/EQMonitor/blob/develop/assets/header.png?raw=true)](https://github.com/EQMonitor/EQMonitor)

[![Github All Releases](https://img.shields.io/github/downloads/EQMonitor/EQMonitor/total.svg)](https://github.com/EQMonitor/EQMonitor/tags)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/EQMonitor/EQMonitor?color=blue&include_prereleases&label=Release)](https://github.com/EQMonitor/EQMonitor/releases/latest)
[![Flutter build Android](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml/badge.svg)](https://github.com/EQMonitor/EQMonitor/actions/workflows/android-release.yaml)

> [!WARNING] > [利用規約](https://github.com/EQMonitor/EQMonitor/blob/main/assets/docs/term_of_service.md)を必ずご確認の上ご利用ください。

![iPad 2](https://github.com/YumNumm/EQMonitor/assets/73390859/127f88f5-9e4f-40b5-a7f2-48efe0932c0c)

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

1. `fvm flutter pub get` で必要なパッケージをインストールします。

   - 本プロジェクトでは、Flutterのバージョン管理に[FVM](https://fvm.app/)を利用しています。

1. Dartプロジェクトを管理するためのツールである[melos](https://melos.invertase.dev/)をインストールします。

   - `dart pub global activate melos` を実行してください。
   - 詳細は、[Get Started](https://melos.invertase.dev/~melos-latest/getting-started)を参照してください。

1. `melos bootstrap` を実行してください。

   - これにより、各パッケージの依存関係が解決されます。

1. `mv .env.example .env` を実行してください。

   - 環境変数の値を設定してください。
   - API保護のため、環境変数の値は公開しません。

1. `fvm flutter run` でアプリケーションを起動します。

<!-- MEMO: Someday, I'll support English.
## Setup

Run the following commands from your terminal:

1. `git clone https://github.com/YumNumm/EQMonitor` to clone this repository

1. `cd EQMonitor` to change directory

1. `flutter pub get` to install the required packages

1. If you are not installed melos which is a tool for managing Dart projects with multiple packages, run `dart pub global activate melos` to install melos
   * See [Get Started](https://melos.invertase.dev/~melos-latest/getting-started) for more information
-->
