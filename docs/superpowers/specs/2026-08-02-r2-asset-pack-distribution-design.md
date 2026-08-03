# Cloudflare R2 Asset Pack 配信の設計

## 背景

EQMonitor の Runner target は iOS 16.0 以降をサポートする一方、現在の
Asset Pack 読込は iOS 26 以降の Managed Background Assets に依存している。
そのため iOS 16〜18 ではアプリをインストールできても、地図・観測点・JMA
code table などを取得できない。

また、iOS、Android で配信経路が異なると、Pack の更新判定、完全性検証、
Change log、障害調査を別々に保守する必要がある。全対応 platform で同一の
署名済み生成物を利用し、OS 固有機能に依存しない更新経路へ統一する。

## 目的

- iOS 16〜18、iOS 26 以降、Android で Cloudflare R2 から Asset Pack を更新する。
- 初回起動時はネットワークを待たず、配布物に同梱した検証済み Pack を利用する。
- Ed25519 署名を信頼の起点として、各 Asset binary の完全性を検証する。
- HomeSheet と設定画面で更新の存在、Change log、進捗、失敗を確認できるようにする。
- Pack の累積 Change log を手書き可能な JSON として管理する。
- 更新失敗時に、最後に検証済みの Pack を確実に継続利用する。

## 対象外

- Asset Pack の自動ダウンロードは行わない。取得開始にはユーザー操作を必要とする。
- `api/api` に Asset Pack 用 endpoint は追加しない。
- GitHub Release をアプリから直接参照しない。
- Apple Hosted Managed Background Assets と Google Play Asset Delivery を更新配信には使わない。
- 個々の Asset binary へ個別の Ed25519 署名は付けない。

Android の既存 install-time Play Asset Delivery Pack は初期 Pack として利用できるが、
アプリインストール後の更新取得には利用しない。

## 採用アーキテクチャ

Cloudflare R2 の custom domain を、全 platform 共通の公開・認証不要な配信元とする。
production の論理 base URL は
`https://assets.eqmonitor.app/v1/assets` とし、アプリには build-time 設定として渡す。
クライアントに R2 credential、GitHub token、署名秘密鍵は含めない。

R2 には次の object を配置する。

```text
v1/assets/
  catalog.json
  catalog.sig
  packs/
    0.0.2/
      manifest.json
      manifest.sig
      map/all.pmtiles
      parameters/jma_code_table.json
      parameters/earthquake_stations.json
      parameters/tsunami_stations.json
      parameters/kyoshin_observation_points.json
      parameters/shindo_db_stations.json
    0.0.3/
      ...
```

`packs/{version}/` 以下は immutable とし、公開後の上書きを禁止する。
更新が必要な場合は必ず新しい SemVer を発行する。`catalog.json` だけが mutable な
latest pointer と累積履歴を兼ねる。

## 信頼モデルと署名

アプリには `key_id` ごとの Ed25519 公開鍵を埋め込む。署名秘密鍵は release CI の
secret としてのみ保持する。鍵ローテーションでは、旧・新公開鍵を含むアプリを先に
配布してから、新しい `key_id` で署名を開始する。

次の 2 つを個別に署名する。

1. `catalog.json` の配信された UTF-8 byte 列
2. 各 version の `manifest.json` の配信された UTF-8 byte 列

アプリは JSON を parse・再 serialize して署名検証しない。取得した byte 列をそのまま
検証し、成功後にだけ JSON として parse する。

`.sig` は次の JSON sidecar とする。

```json
{
  "schema_version": 1,
  "algorithm": "Ed25519",
  "key_id": "asset-signing-2026-01",
  "content_sha256": "<lowercase hex>",
  "signature_base64": "<base64>"
}
```

`content_sha256` は配信・cache の組合せ違いを診断するための値であり、真正性は
Ed25519 署名で判定する。未知の `key_id`、algorithm、signature schema は拒否する。

各 Asset binary は `manifest.json` に記録された size と SHA-256 で検証する。
すなわち信頼連鎖は「アプリ内公開鍵 → manifest 署名 → Asset SHA-256」であり、
binary ごとの署名 file は不要とする。

## Catalog

`catalog.json` は最新 version と全 Change log 履歴を新しい順で保持する。

```json
{
  "schema_version": 1,
  "revision": 3,
  "latest_version": "0.0.3",
  "generated_at": "2026-08-02T00:00:00Z",
  "packs": [
    {
      "version": "0.0.3",
      "published_at": "2026-08-02",
      "minimum_app_version": "3.0.0",
      "download_size_bytes": 17301504,
      "manifest_path": "packs/0.0.3/manifest.json",
      "signature_path": "packs/0.0.3/manifest.sig",
      "localizations": {
        "ja": {
          "sections": [
            {
              "title": "更新",
              "items": ["観測点データを更新しました"]
            }
          ]
        },
        "en": {
          "sections": [
            {
              "title": "Changes",
              "items": ["Updated observation point data"]
            }
          ]
        }
      }
    }
  ]
}
```

version は prerelease を含まない `MAJOR.MINOR.PATCH` に限定する。`revision` は
catalog 公開ごとに増加する正の整数とする。`latest_version` は `packs` の先頭かつ
最大 version と一致しなければならない。各 entry の version は一意とし、日本語・英語の
両方に 1 件以上の section と item を要求する。

手書き元は repository の `tool/asset_pack/changelog.json` とする。この JSON は
version、公開日、minimum app version、日本語・英語の sections を累積保持する。
release CI は Pack の manifest から `download_size_bytes` と version 固定 path を加え、
配信用 `catalog.json` を生成する。過去 entry は append-only とし、CI は現在 R2 にある
署名済み catalog と比較して、過去 entry の削除・変更、revision の巻き戻し、version の
重複を拒否する。

アプリは端末 locale が日本語なら `ja`、それ以外なら `en` を表示する。更新を複数世代
飛ばした場合は、現行 version より新しく候補 version 以下の entry をすべて表示する。

## Manifest

既存 manifest を拡張し、少なくとも次を保持する。

- `schema_version`
- `pack_version`
- `generated_at`
- Asset ごとの logical ID、kind、relative path、`size_bytes`、`sha256`

manifest 自身、signature sidecar、catalog は Asset 一覧へ含めない。Asset path は
R2 prefix と端末 staging root のどちらにも安全に連結できる正規化済み relative path
とする。空 path、absolute path、`.`、`..`、空 segment、backslash、重複 path、
重複 logical ID を拒否する。

アプリは既知の必須 logical ID がすべて 1 件ずつ存在すること、kind が期待値と一致する
こと、file size が正の値かつ platform の上限以下であることを確認する。

## 初期 Pack と端末 storage

iOS は初期 Pack を Runner bundle に同梱する。Android は既存の install-time Pack を
read-only の初期 Pack として利用する。どちらも release CI で同じ manifest 署名、
size、SHA-256 検証を通した同一 version の生成物を stage する。

端末では次を区別する。

- read-only のアプリ同梱 Pack
- writable な現行 download Pack
- writable な直前 download Pack
- download 中の staging directory

現行 Pack の選択情報は専用 storage key enum を通して永続化し、key 文字列をコードへ
直書きしない。起動時は候補を検証し、互換性のある最も新しい Pack を選ぶ。アプリ更新で
同梱 Pack が現行 download Pack より新しくなった場合は、新しい同梱 Pack を選択する。

有効化後も直前の download Pack 1 世代と同梱 Pack を保持する。staging は有効化対象と
して参照しない。cleanup は現行 pointer の更新が完了した後にだけ行う。

## 更新確認と UI

アプリは起動を catalog 通信で block せず、現在の検証済み Pack で画面を表示する。
その後 `catalog.json` と `catalog.sig` を ETag / `If-None-Match` 付きで取得する。

次をすべて満たした場合だけ更新候補として扱う。

- catalog 署名が正しい。
- schema、revision、version 順、entry、path が妥当である。
- latest version が同梱・現行 Pack より新しい。
- revision と latest version が、端末で最後に受理した catalog より古くない。
- 対象 Pack の `minimum_app_version` を現在のアプリが満たす。

更新がある場合、HomeSheet と設定画面は同じ Riverpod state を監視して更新 card を
表示する。card には候補 version、現在より新しい全 Change log entry、取得 size、
「更新する」button を含める。自動 download は開始しない。

minimum app version を満たさない場合は Asset download button を表示せず、アプリ更新が
必要であることを表示する。catalog 取得・検証に失敗した場合は未検証の Change log を
表示しない。

設定画面には、cache 済みの検証済み catalog から全 Change log 履歴を表示できる入口も
設ける。

## Download と有効化

ユーザーが更新を開始すると、次の順で処理する。

1. version 固定 path から manifest と signature を取得する。
2. manifest の Ed25519 署名、schema、version、path、必須 Asset を検証する。
3. manifest の合計 size と staging・直前世代保持分を考慮して空き容量を確認する。
4. 各 Asset を staging directory へ download する。
5. file ごとに size と SHA-256 を検証する。
6. JSON parse、PMTiles header など、利用開始前に実行可能な内容検証を行う。
7. 全検証に成功した staging directory を version directory へ atomic rename する。
8. 現行 Pack pointer を新 version へ atomic に更新する。
9. Asset を読む provider を invalidate し、新 Pack を開き直す。
10. 直前の 1 世代を残して古い download Pack を cleanup する。

catalog 内の absolute URL は受け入れない。固定した HTTPS base URL と、検証済みの
relative path から URL を組み立てる。

### iOS

Runner の deployment target は 16.0 を維持する。background `URLSession` の固有
identifier を使い、アプリが suspend・terminate された場合も OS が download を継続
できるようにする。再起動後は background session へ再接続し、完了済み file の検証と
staging 復元を行う。server の Range response を利用して中断 file を再開する。

Managed Background Assets の `AssetDownloader` extension、Background Assets 用
Info.plist key、Managed Background Assets 専用 App Group 設定、runtime API、
App Store Connect upload job は削除する。別用途でも使用する既存 App Group や
`UIBackgroundModes` は削除しない。

### Android

OS の制約下で継続可能な background worker を使い、R2 から同じ object を download
する。初期 Pack は install-time Pack から読むが、download 後は app-private storage の
現行 Pack を優先する。worker の再実行でも同じ staging version を再利用し、重複 download
と二重有効化を防ぐ。

## R2 と cache policy

- `packs/{version}/**`: `Cache-Control: public, max-age=31536000, immutable`
- `catalog.json` / `catalog.sig`: revalidation を要求し、ETag を付与する
- Asset object: `Accept-Ranges: bytes` を利用できる構成にする
- Content-Type: JSON、signature JSON、PMTiles を明示する
- version prefix の既存 object が 1 件でも存在する場合、publish を失敗させる

catalog と sidecar は 2 object なので、同時に atomic 更新できない。release 時は新しい
`catalog.sig` を先に、`catalog.json` を最後に upload する。一時的な組合せ不一致や CDN
cache のずれは署名検証で fail closed し、クライアントは現行 Pack を維持して再試行する。

## Release pipeline

既存の private `YumNumm/eqmonitor-backend` GitHub Release を canonical な Pack 生成元として
維持する。client は private Release を参照しない。

release workflow は次を実行する。

1. private Release の Pack と checksum を取得する。
2. 必須 Asset、layout、manifest、size、SHA-256 を検証する。
3. `tool/asset_pack/changelog.json` の手書き Change log entry を検証する。
4. manifest を release 用 Ed25519 key で署名する。
5. version 固定 object を R2 へ upload する。
6. R2 から全 object を再取得し、署名、size、SHA-256 を再検証する。
7. 現行の署名済み catalog を取得し、過去履歴が不変であることを確認する。
8. 新 entry と増加した revision を持つ catalog を生成・署名する。
9. `catalog.sig`、最後に `catalog.json` を upload する。
10. 公開 catalog から対象 Pack を再取得して end-to-end 検証する。

同一 version の再公開や、検証前の catalog 更新を禁止する。どの段階で失敗しても旧 catalog
と旧 Pack は引き続き利用可能でなければならない。

## エラー処理

- catalog 取得失敗: 現行 Pack を継続し、検証済み cache があれば履歴表示に使う。
- catalog 署名不正・巻き戻し: 更新候補として扱わず security event を記録する。
- 未知の署名鍵: 更新を拒否し、アプリ更新が必要な可能性を診断へ表示する。
- manifest 取得・署名失敗: Asset download を開始しない。
- 通信中断: staging を保持し、同じ version の次回操作で再開する。
- 空き容量不足: download 前に必要容量を表示し、現行 Pack を変更しない。
- size・SHA-256・内容検証失敗: staging を有効化せず破棄し、現行 Pack を維持する。
- pointer 更新失敗: 起動時の整合性検査で旧現行 Pack を選び、孤立した新 Pack は診断対象にする。
- provider 再読込失敗: 直前 Pack へ戻し、失敗した Pack を再選択しない。

例外文字列を主要 UI にそのまま表示しない。ユーザーには再試行可能性と必要操作を示し、
詳細は talker とデバッグ画面へ構造化して記録する。固定値、fake data、不完全な Pack へ
fallback しない。

## デバッグ画面

既存 Asset Pack デバッグ画面を R2 配信モデルへ更新し、次を表示する。

- CDN base URL と catalog ETag
- catalog schema、revision、生成日時、署名 `key_id`、検証結果
- 同梱・現行・直前・staging の version と選択元
- candidate version、minimum app version、Change log 件数
- background download identifier / worker state、進捗、再開可否
- 各 Asset の relative path、期待・実 size、SHA-256 検証状態
- 最後の更新確認、download、検証、有効化の結果

秘密情報と完全な端末 path は表示しない。長い詳細は折返し・copy 可能にし、text scale を
拡大しても overflow しない構成にする。

## テスト

### Domain・Data

- Ed25519 known-answer test、正常署名、不正署名、未知 `key_id`
- 取得 byte 列と再 serialize JSON の違いを検出すること
- catalog schema、revision rollback、SemVer 順、重複、locale 欠落
- path traversal、absolute path、重複 Asset ID / path、未知 kind
- manifest の必須 Asset、size、SHA-256、version 一致
- 同梱、download、直前 Pack から最新の互換 Pack を選ぶこと
- catalog ETag cache と 304 response

### Download・Storage

- Range 再開、通信中断、process 終了後の staging 復元
- 空き容量不足、途中 file、size mismatch、hash mismatch
- atomic rename と pointer 更新の各失敗点
- 全検証完了前に新 Pack を参照しないこと
- 有効化失敗時に現行 Pack、成功後に直前 1 世代を保持すること
- 同じ version の多重 download・多重有効化を防ぐこと

### UI

- HomeSheet と設定の更新あり、複数 version の Change log
- download 待機、進捗、再開、失敗、完了
- minimum app version 不一致と未知署名鍵
- offline、catalog 不正、検証済み cache 利用
- text scale と長い日英 Change log で overflow しないこと

### Platform・Release

- iOS 16、iOS 18、iOS 26 以降で初期 Pack と R2 更新が動作すること
- iOS background session の suspend、terminate、再起動復元
- Android 最低対応 API と現行 API の background worker
- release dry-run、既存 version 拒否、履歴改変拒否
- R2 upload 後の署名・全 Asset end-to-end 再検証

iOS 19〜25 は存在しないため、存在しない OS version を test matrix や分岐条件へ記載しない。

## 移行

1. catalog / signature schema と client verifier を追加する。
2. 現行 Pack を初期 Pack として iOS bundle と Android 配布物へ stage する。
3. R2 download、storage、更新 UI を導入し、旧 platform Pack と並行検証する。
4. R2 release pipeline と production custom domain を有効化する。
5. R2 経路の実機検証後、Managed Background Assets runtime と upload pipeline を削除する。
6. 旧 Managed Background Assets の端末上 storage は OS 管理に任せ、新実装から参照しない。
7. Managed Background Assets 前提の既存 knowledge document を現行設計に合わせて訂正する。

移行途中でも、検証済み初期 Pack または既存の検証済み Pack が必ず利用可能な順序で release
する。新 download 経路が利用可能になる前に旧経路を削除しない。

## 完了条件

- iOS 16〜18、iOS 26 以降、Android が同梱 Pack で offline 起動できる。
- 全 platform が署名済み catalog で更新を検出し、R2 から同一 Pack を取得できる。
- HomeSheet と設定に、現在より新しい全 Change log と手動更新操作が表示される。
- manifest 署名、全 file の size・SHA-256・内容検証後だけ Pack が有効化される。
- 通信断、改ざん、容量不足、process 終了でも現行 Pack が失われない。
- catalog 履歴を JSON で追記し、安全に release できる。
- Managed Background Assets への runtime・capability・CI 依存がなくなる。
