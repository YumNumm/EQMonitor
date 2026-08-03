# EQMonitor - 地震速報・監視アプリケーション

[![Github All Releases](https://img.shields.io/github/downloads/EQMonitor/EQMonitor/total.svg)](https://github.com/EQMonitor/EQMonitor/tags)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/EQMonitor/EQMonitor?color=blue&include_prereleases&label=Release)](https://github.com/EQMonitor/EQMonitor/releases/latest)

|                                                                                    Android                                                                                     |                                                                                                iOS                                                                                                |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| [<img src="https://github.com/YumNumm/YumNumm/raw/main/resources/img/google-play-badge.png" height="50">](https://play.google.com/store/apps/details?id=net.yumnumm.eqmonitor) | [<img src="https://github.com/YumNumm/YumNumm/raw/main/resources/img/appstore-badge.png" height="50">](https://apps.apple.com/ja/app/eqmonitor-%E5%9C%B0%E9%9C%87%E9%80%9F%E5%A0%B1/id6447546703) |

> [!WARNING] > [利用規約 - Term of Service](https://github.com/EQMonitor/EQMonitor/blob/main/assets/docs/term_of_service.md)を必ずご確認の上ご利用ください。

![iPad1](https://github.com/YumNumm/EQMonitor/assets/73390859/4196623d-222e-4eac-991a-fee5a976be76)

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

1. プロジェクトをcloneします。

```bash
git clone https://github.com/EQMonitor/EQMonitor.git
cd EQMonitor
```

> [!NOTE]
> 本リポジトリは、submoduleとして[`YumNumm/eqmonitor-backend`](https://github.com/YumNumm/eqmonitor-backend)を含んでいます。
> eqmonitor-backendはPrivate Repositoryであるため、クローンできない場合があります。
> アプリケーションのビルド時には、submoduleを利用する必要はありません。
> バックエンド実装をオープンソースにする予定はありません。

1. [mise-en-place](https://mise.jdx.dev/)をインストールしてください

1. Flutter pluginを登録します。`mise.toml`にも同じURLを宣言しているため、通常は省略できます。

   ```bash
   mise plugin install flutter https://github.com/YumNumm/mise-flutter.git
   ```

1. Flutterなどの依存関係をダウンロードします。

   ```bash
   mise install
   mise exec -- flutter --version --machine
   ```

1. Swift Package Managerを利用するために、以下のコマンドを実行してください

    - [Swift Package Manager for app developers](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers)

    ```bash
    mise exec -- flutter config --enable-swift-package-manager
    ```

1. Dart workspaceの依存関係を解決し、[melos](https://melos.invertase.dev/)で各packageをbootstrapします。

   ```bash
   mise exec -- dart pub get --enforce-lockfile
   mise exec -- dart run melos bootstrap
   ```

   - これにより、各パッケージの依存関係が解決されます。

1. `mv environment/.env.example environment/.env.dev` を実行してください。

1. `mise exec -- flutter run` でアプリケーションを起動します。

   > [!NOTE]
   > **iOS**: AppIntent / Widget 用の slim `app/assets/parameters/jma_code_table.json` はリポジトリに同梱済みです。clone 直後でもビルドできます。
   > **Android / macOS**: 地図・パラメータ一式は git に含めません。ビルド前に backend Release から配置してください（`GH_TOKEN` が必要）:
   >
   > ```bash
   > export GH_TOKEN=...
   > tool/asset_pack/stage_from_release.sh --target android   # または macos / both
   > ```
   >
   > 詳細: [`docs/knowledge/20260728_asset_pack_release_staging.md`](./docs/knowledge/20260728_asset_pack_release_staging.md)

## コントリビューション

[CONTRIBUTING.md](./docs/CONTRIBUTING.md)を参照してください。
