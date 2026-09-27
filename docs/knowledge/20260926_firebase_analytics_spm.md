# Firebase Analytics の SPM クラッシュ調査

2026-09-26 確認。対象は TestFlight 3.0.0 (1933)、Incident
`D4AB05F9-8580-49DB-889C-9197CFF6975E`。

- `APMMeasurement networkRemoteConfigFetchCompletionHandler:data:error: +1704`
  から Objective-C の unrecognized selector 例外で終了している。
- Firebase の既知不具合 #16634 と呼出し経路・オフセットが一致する。
  SPM の GoogleAppMeasurement 12.19.0 で、`-ObjC` なしの場合に
  `fetchSBT` が見つからない回帰が報告され、12.19.2 で修正された。
- 今回のログはクラス名・selector が `%s` になっているため、
  `fetchSBT` であることとビルド 1933 の組込み SDK バージョンは未確認。
  iOS ベータ固有の障害とは断定しない。
- `origin/develop` の `81386a797` では、iOS の project 内の
  `Package.resolved` は GoogleAppMeasurement 12.19.2、
  workspace 内は 12.19.0。Firebase 本体は両方とも 12.19.0。
- CI は `xcodebuild archive -workspace ios/Runner.xcworkspace` を使う。
  project 側の lockfile 更新だけで配布物への修正反映を判断しない。

## 確認・対応手順

1. ビルドに使う workspace で GoogleAppMeasurement を 12.19.2 に揃える。
   FlutterFire の firebase_core 4.15.0 / firebase_analytics 12.6.0 は
   Firebase 本体を 12.19.0 に完全固定するため、本体の lockfile だけを更新しない。
   Firebase 12.19.0 は GoogleAppMeasurement 12.19.0 以上・12.20.0 未満を許容し、
   内部依存だけの更新も公式の修正手順に含まれる。
2. `xcodebuild -resolvePackageDependencies -workspace app/ios/Runner.xcworkspace -scheme Runner`
   の出力と両方の `Package.resolved` を確認する。
3. Release の成果物と実機動作を確認してから修正済みと判断する。
   workspace の lockfile は更新済み。Release 再ビルド・実機検証は未実施。

参照: [公式 Issue #16634](https://github.com/firebase/firebase-ios-sdk/issues/16634)、
[Firebase Apple SDK リリースノート](https://firebase.google.com/support/release-notes/ios)。
