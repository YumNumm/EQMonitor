# Firebase Analytics SPMのObjective-Cリンク設定

## 調査対象

- TestFlight 3.0.0 (1933)、Incident AAA49517-3F99-4375-985A-DB55A33016A0。
- 起動約17秒後、`APMMeasurement networkRemoteConfigFetchCompletionHandler:data:error: + 1704` で未認識selectorのObjective-C例外 → SIGABRT。
- 提供ログではselectorが `%s` に置換されているため、`fetchSBT` との同一性は断定できない。
- 最新developのSPM lockはFirebase/GoogleAppMeasurement 12.19.0。ビルド1933の実際の依存・バイナリとの照合は未実施。

## 対応ルール

Firebase AnalyticsをSPM経由で組み込むRunnerでは、Debug/Release/Profileの全てに `OTHER_LDFLAGS = $(inherited) -ObjC` を維持する。ProfileはRelease.xcconfigを参照する。

Firebase開発者は同一スタックの `fetchSBT` クラッシュを `-ObjC` 欠落で再現し、このフラグを回避策として案内した。12.19.2で修正済みと回答している。

- https://github.com/firebase/firebase-ios-sdk/issues/16634
- https://github.com/firebase/firebase-ios-sdk/blob/main/SwiftPackageManager.md

```sh
cd app/ios
xcodebuild -project Runner.xcodeproj -target Runner -configuration Release -showBuildSettings | rg OTHER_LDFLAGS
# Debug、Profileでも確認する。
```

今回追加したのは公式必須設定であり、SDKの一括更新はしない。原因候補への修正であり、実機でクラッシュ解消を確認した状態ではない。再ビルドしたTestFlightで再インストール・起動後のAnalytics設定取得まで確認する。

Xcodeの `-showBuildSettings` でDebug・Release・Profileの `OTHER_LDFLAGS = -ObjC` を確認済み。実機ビルド・実行は未検証。
