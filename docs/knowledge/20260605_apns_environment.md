# APNs environment は iOS entitlements に合わせる

## ルール

APNs token を backend へ同期するときの `environment` は、Flutter flavor ではなく iOS の `aps-environment` entitlement に合わせる。

現状の iOS entitlements は以下の通り production:

- `app/ios/Runner/Runner.entitlements`
- `app/ios/Widget/Widget.entitlements`

そのため app 側の APNs token sync では `ApnsEnvironment.production` を送る。dev flavor だからといって `development` にすると、backend が sandbox APNs endpoint へ送信し通知が届かない可能性がある。

確認例:

```bash
rg "aps-environment" app/ios -n
```
