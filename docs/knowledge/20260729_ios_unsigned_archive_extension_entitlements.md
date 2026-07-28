# iOS unsigned archive の extension entitlement を export 前に保持する

## 症状

`xcodebuild archive` と `xcodebuild -exportArchive` は成功するが、App Store
Connect への IPA upload が `90958` で失敗する。

```text
Missing Entitlement. The AssetDownloader.appex Background Assets extension
and/or its parent app bundle are missing the
com.apple.security.application-groups entitlement.
```

## 原因

CD は cloud-managed certificate を使うため、archive を
`CODE_SIGNING_ALLOWED=NO` で作成する。その後に framework と Runner だけを
ad-hoc 署名すると、埋め込み extension は entitlement 付きの署名を持たないまま
export に渡る。Background Assets は親アプリと downloader extension の両方に
共通の App Group を要求するため、App Store Connect の検証で拒否される。

また、extension target の `DEVELOPMENT_TEAM` が Runner / ExportOptions と違うと、
自動署名時の team と provisioning profile の選択も不整合になる。

## 対策

`scripts/ci/sign_ios_archive_for_export.sh` で、次の内側から外側の順に ad-hoc
署名してから `xcodebuild -exportArchive` を実行する。

1. framework
2. 各 `.appex`（target ごとの entitlement file を指定）
3. Runner.app

全 target の `DEVELOPMENT_TEAM` は ExportOptions の `CPL7H8SHVM` に揃える。

## 検証

```bash
scripts/ci/test_sign_ios_archive_for_export.sh
scripts/ci/test_asset_downloader_build_settings.sh
```

最終的な App Store 用 IPA でも Runner と `AssetDownloader.appex` の両方を確認する。

```bash
codesign -d --entitlements :- Payload/Runner.app | plutil -p -
codesign -d --entitlements :- \
  Payload/Runner.app/Extensions/AssetDownloader.appex | plutil -p -
```

どちらにも `com.apple.security.application-groups` の
`group.net.yumnumm.eqmonitor` が必要。
