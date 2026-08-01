# iOS の Firebase アプリが未登録扱いになっている

## 優先度が高い理由

Firebase Installations が失敗すると FCM 登録トークンを取得できない。
このアプリでは FCM が緊急地震速報の配信経路であるため、
**この状態のビルドでは EEW のプッシュ通知が届かない**。

## 症状

実機起動時に Google API から 400 が返る。

```json
{
  "error": {
    "code": 400,
    "message": "App not registered: 1:179553945248:ios:a738f33a18702c7f6fabc5.",
    "status": "FAILED_PRECONDITION"
  }
}
```

`app/ios/Runner/GoogleService-Info.plist` の値。

| キー | 値 |
| --- | --- |
| `GOOGLE_APP_ID` | `1:179553945248:ios:a738f33a18702c7f6fabc5` |
| `BUNDLE_ID` | `net.yumnumm.eqmonitor` |
| `PROJECT_ID` | `eqmonitor-main` |

`GoogleService-Info.plist` はコミット `e1cccbcd9`（かなり以前）以降変更されていないため、
アプリ側の設定変更ではなく Firebase / GCP プロジェクト側の状態変化が原因と考えられる。

## 調査すべきこと

1. Firebase コンソールの `eqmonitor-main` プロジェクトに、上記 App ID の iOS アプリが存在するか
   - 削除されている場合は再登録し、`GoogleService-Info.plist` を再取得して差し替える
2. GCP で Firebase Installations API (`firebaseinstallations.googleapis.com`) が有効か
   - 無効化・課金停止で `FAILED_PRECONDITION` になる場合がある
3. macOS 版（`app/macos/Runner/GoogleService-Info.plist`）でも同じ事象が起きるか

```bash
npx firebase-tools login
npx firebase-tools apps:list IOS --project eqmonitor-main
```

## 検証方法

修正後、実機で起動して以下を確認する。

- 起動ログに `App not registered` が出ないこと
- FCM 登録トークンが取得でき、テスト通知が受信できること

## 補足（別件として要確認）

`Info.plist` の `GIDClientID` / URL スキームと `GoogleService-Info.plist` の
`CLIENT_ID` / `REVERSED_CLIENT_ID` の OAuth クライアント ID が一致していない。

- `Info.plist`: `179553945248-t7tu1idt4r6hlbbegau7817r283c5mhr`
- `GoogleService-Info.plist`: `179553945248-hog16qgussjvd0ddqqe973c32n64atm1`

意図的なものか、Google Sign-In が動作しなくなる不整合かを確認すること。
