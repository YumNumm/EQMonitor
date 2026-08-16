# R2 Asset Pack 配布とアプリ同梱 fallback

## ルール

- Asset Pack の runtime 配布先は Cloudflare R2 custom domain
  `https://assets.eqmonitor.app/v1/assets` とする。
- iOS Managed Background Assets / Android Play Asset Delivery は使わない。
- アプリリリース時は、同じ R2 公開物を検証して
  `app/assets/platform/` に同梱する。
- runtime update の異常時は同梱 Pack へ戻す。同梱 Pack は cleanup 対象に
  含めない。

## 公開順序

backend は次の順で R2 object を公開する。

1. immutable ZIP
2. `manifest.sig`
3. `manifest.json`

トップレベル manifest を最後にすることで、クライアントが未公開 ZIP を指す
新 manifest を先に観測しないようにする。公開後は R2 から再取得して Ed25519
署名と ZIP SHA-256 を検証してから repository dispatch を送る。

## アプリビルド

```bash
tool/asset_pack/stage_from_r2.sh --target bundled
# iOS native extension の縮小テーブルも更新する場合
tool/asset_pack/stage_from_r2.sh --target all
```

このスクリプトは manifest 署名、entry、ZIP size / SHA-256、必須レイアウトを
検証してから `platform/` を置き換える。秘密鍵は不要で、公開鍵だけを使う。

## runtime の安全条件

- `manifest.json` は `manifest.sig` の Ed25519 署名が正しい場合だけ保存する。
- 受理済み revision / latest version より古い manifest は拒否する。
- ZIP の size / SHA-256 を展開前に検証する。
- Zip Slip、absolute / drive / backslash path、dot segment、重複 path、symlink、
  file count、単一 file size、総展開 size を拒否する。
- 展開後は manifest に記載された全 file（未知の将来 ID も含む）の size /
  SHA-256 を検証し、未宣言 file を拒否する。
- 検証済み staging を activate してから active preference を更新する。
- active downloaded Pack の read / integrity check が失敗したら active preference
  と該当 directory を外し、同じ read を同梱 Pack で一度だけ再試行する。
- 新 version activate 後は、それ以外のダウンロード version を削除する。
- アプリ更新後に同梱 version の方が新しければ、古い active download を削除して
  同梱 Pack を選ぶ。
- background download は version 固定 task ID を使う。起動後に downloader の
  永続DBを復元し、完了済みZIPがあれば重複取得せず検証へ進める。

## 鍵ローテーション

現在の key id は `asset-pack-2026-08-16`。秘密鍵 DER の Base64 は backend の
GitHub secret のみに保存する。公開鍵はアプリと CI verifier に同じ raw
Ed25519 key を登録する。旧鍵で署名された manifest が cache / CDN に残る期間は
旧公開鍵を削除しない。
