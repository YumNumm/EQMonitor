# R2 Asset Pack production provisioning

ローカル実装と静的・単体テストは完了しているが、production の外部状態は未作成。
この作業環境には `backend/home8s/.config/age/age.txt` がなく、Cloudflare 用の
SOPS secretsを復号できない。また `assets.eqmonitor.app` は2026-08-16時点で
DNS解決できない。

## 必須作業

- home8s の Age key を用意した認証済み環境で次を実行する。

  ```bash
  cd backend/home8s
  mise exec -- tofu -chdir=terraform/cloudflare plan
  mise exec -- tofu -chdir=terraform/cloudflare apply
  ```

- backend repository に次を登録する。
  - secret `ASSET_PACK_SIGNING_PRIVATE_KEY_BASE64`
  - variable `ASSET_PACK_SIGNING_KEY_ID=asset-pack-2026-08-16`
  - secret `CLOUDFLARE_API_TOKEN`
  - variable `CLOUDFLARE_ACCOUNT_ID`
- `release-asset-pack.yaml` を既存latest Releaseに対する
  `force_redispatch=true` で実行し、R2をbootstrapする。
- 公開後に以下を確認する。

  ```bash
  curl -fsSI https://assets.eqmonitor.app/v1/assets/manifest.json
  curl -fsSI https://assets.eqmonitor.app/v1/assets/manifest.sig
  tool/asset_pack/stage_from_r2.sh --target bundled
  ```

- Android SDK環境でdebug APK/AAB、macOS/Xcode環境でiOS config buildを実行し、
  同梱Packのoffline起動とR2更新を実機確認する。
