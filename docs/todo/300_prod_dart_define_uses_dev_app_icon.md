# production の dart-define が dev のアプリアイコンを指している

## 事象

`environment/.env.prod`（CI では secret `DART_DEFINE_PRODUCTION`）が
`APP_ICON=AppIcon-dev` を設定している。

CI の `Create XCArchive` の環境変数ダンプでも確認済み。

```
export APP_ICON=AppIcon-dev
export ASSETCATALOG_COMPILER_APPICON_NAME=AppIcon-dev
export APP_NAME=EQMonitor β
```

`app/ios/AppIcon-prod.icon` は存在するが、production ビルドでは
`AppIcon-dev.icon` がプライマリアイコンとして選択されている。

## 影響

TestFlight / App Store に出るビルドが dev 用アイコンで配信される。
`ASSETCATALOG_COMPILER_INCLUDE_ALL_APPICON_ASSETS = YES` のため
`AppIcon-prod` も Assets.car には入るが、使われるのは dev 側。

## 対応

意図的（β配信中は dev アイコン）でなければ、次を更新する。

- ローカル: `environment/.env.prod` の `APP_ICON=AppIcon-prod`
- CI: GitHub secret `DART_DEFINE_PRODUCTION`（base64）を再生成

意図的なら、その旨を `environment/.env.example` にコメントで残す。
