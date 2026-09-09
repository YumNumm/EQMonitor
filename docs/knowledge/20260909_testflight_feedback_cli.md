# TestFlight フィードバックの取得

- App Store Connect 認証情報はルートの `.env.json` に SOPS 暗号化で保存されている。
- `asc` が未認証でも、既存の暗号化済み認証情報を確認する。
- ローカルの age 秘密鍵は `.config/age/age.txt` に配置する。
- 復号した JSON や秘密鍵を標準出力・ログ・Git に出さない。
- asc に渡す環境変数は以下の対応で設定する。

| asc | `.env.json` |
| --- | --- |
| `ASC_KEY_ID` | `APP_STORE_CONNECT_API_KEY_ID` |
| `ASC_ISSUER_ID` | `APP_STORE_CONNECT_API_ISSUER_ID` |
| `ASC_PRIVATE_KEY_B64` | `APP_STORE_CONNECT_API_KEY_BASE64` |
| `ASC_APP_ID` | `APP_STORE_CONNECT_APP_APPLE_ID` |

復号は次のコマンドを子プロセスから呼び、標準出力をメモリ内で JSON として処理する。
SOPS の shim にバージョンが設定されていない環境では明示指定する。

```bash
SOPS_AGE_KEY_FILE="$PWD/.config/age/age.txt" \
  mise exec sops@3.13.3 -- sops --decrypt .env.json
```

認証環境変数と `ASC_BYPASS_KEYCHAIN=1` を取得用の子プロセスに渡す。

```bash
asc testflight feedback list --paginate --include-screenshots --sort=-createdDate --output json
asc testflight crashes list --paginate --sort=-createdDate --output json
```

- `data` の件数と `meta.paging.total` を比較し、`links.next` が残っていないことを確認する。
- スクリーンショット URL は期限付き。取得結果の `expirationDate` を参照する。
- 投稿データにはメールアドレス等が含まれるため、Git 管理外に権限 `0600` で保存する。
- 2026-09-09 にフィードバック60件・クラッシュ報告9件の取得を確認した。
