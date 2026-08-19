# Asset Pack native release validation

R2 bucket、`assets.eqmonitor.app` custom domain、署名鍵、Actions設定と初期Pack公開は
productionへ適用済み。残るのは実機相当のnative release build検証。

- Android SDK環境でdebug APK/AABをbuildし、同梱Packのoffline起動、更新同意、
  download進捗、R2更新適用、破損時fallbackを確認する。
- macOS/Xcode環境でiOS config buildを実行し、同じシナリオを確認する。
- 確認後、このtodoを削除する。
