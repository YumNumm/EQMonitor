# TestFlight(BETA×prod)での App Check 検証手段の欠落

## 背景

`BuildConfig.isDeveloperUiEnabled`(`app/lib/core/model/environment.dart`)を導入し、
BETA(`IS_BETA_TESTING=true`)かつ production flavor(`FLAVOR=prod`)のビルドでは
デバッグメニュー・HTTP キャッシュ表示・`DebugLauncher` のシェイク/ショートカット起動を
すべて無効化した。

通常の TestFlight ビルドはまさに BETA×prod のため、
`docs/beta/ios-testflight-checklist.md` の「4.1 アプリ内デバッグページで確認する」
(`_AppCheckSection` によるトークン確認)が **実施できなくなった**。

## 影響

- App Check トークンのアプリ内目視確認が TestFlight で行えない。
- 現状は「4.2 Firebaseコンソールで確認する」(Verified requests の増加確認)で代替可能。

## 検討事項

- App Check の確認をコンソール確認のみに正式集約するか、
  デバッグ UI に依存しない軽量な確認導線(例: 限定的な検証用画面や CI ログ出力)を
  用意するかを決める。
- どうしてもアプリ内で確認したい場合の運用として、`FLAVOR=dev` など
  `isDeveloperUiEnabled == true` になる検証専用ビルドの配布手順を定める。
