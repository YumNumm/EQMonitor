# iOS CD: xcodebuild | xcbeautify は pipefail 必須 / AssetDownloader の deployment target

## 症状

`deploy-app` の Build iOS が `Embed entitlements and ad-hoc sign` で
`Runner.app: No such file or directory` と落ちる一方、`Create XCArchive` は
success に見えることがある。

## 原因

```yaml
xcodebuild archive ... | xcbeautify ...
```

GitHub Actions のデフォルト bash は `pipefail` 無し。`xcodebuild` が非ゼロでも
パイプ右側の `xcbeautify` が 0 ならステップ全体が成功扱いになる。

## 対策

`pipefail` を付けるだけでは不十分。GitHub Actions の `run:` は
`shell: /bin/bash -e {0}` で動くため、パイプが失敗した時点で errexit により
スクリプトが即終了し、`PIPESTATUS` を見る診断コードに到達しない。
**パイプ全体を `if !` の中に置く**こと。

```yaml
set -o pipefail
if ! xcodebuild archive ... 2>&1 \
  | tee /tmp/xcodebuild-archive.log \
  | xcbeautify --renderer github-actions; then
  # xcbeautify は actool/ibtoold の診断を捨てるので raw log から拾う
  echo "::group::xcodebuild raw errors"
  grep -n -A 5 -E '^(error:|.*\*\* ARCHIVE FAILED)' /tmp/xcodebuild-archive.log || true
  echo "::endgroup::"
  echo "::error::xcodebuild archive failed. Tail of raw log:"
  tail -n 200 /tmp/xcodebuild-archive.log
  exit 1
fi
```

`Create IPA` / `Create Ad-Hoc IPA` も同様に `set -o pipefail` を付ける。

## AssetDownloader の IPHONEOS_DEPLOYMENT_TARGET

CI の Xcode 26.3 は deployment target の上限が **26.2.99**。
`AssetDownloader` が `26.5` だと warning（環境によっては失敗要因）になる。
Runner 本体に合わせて **26.0** に揃える。

## 関連

- jma_code_table 欠落は別件で解消済み（`stage_from_release.sh --target ios-native`）
- 実際に exit 65 の原因だった actool クラッシュは
  `docs/knowledge/20260729_icon_composer_actool_crash.md` を参照
