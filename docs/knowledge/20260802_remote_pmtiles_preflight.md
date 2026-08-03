# リモート PMTiles の事前検証

MapLibre にリモート PMTiles を渡すときは、描画レイヤーの追加前に対象ファイルを検証する。
MapLibre の Flutter ラッパーからは、個々の source の読み込み失敗を画面状態へ確実に返せないためである。

## 検証条件

- `Range: bytes=0-127` で取得する
- HTTP 206 のみ受理し、Range を無視した HTTP 200 は拒否する
- `Content-Range` が `bytes 0-127/<全体サイズ>` と一致することを確認する
- 先頭7バイトが `PMTiles`、8バイト目の version が `3` であることを確認する
- ヘッダー判定に必要な8バイトを読んだら stream を中断する
- Range 非対応時にファイル全体の GET へフォールバックしない

デプロイ先の確認例:

```bash
curl --fail --silent --show-error \
  --header 'Range: bytes=0-127' \
  --dump-header /tmp/hypocenter-pmtiles.headers \
  --output /tmp/hypocenter-pmtiles.header \
  'https://example.invalid/hypocenters/day/2026-08-02.pmtiles'
sed -n '1,20p' /tmp/hypocenter-pmtiles.headers
xxd -l 8 /tmp/hypocenter-pmtiles.header
```

MapLibre の source URL は、manifest の HTTPS URL に `pmtiles://` を一度だけ付与する。
既に `pmtiles://` が付いている場合は重ねて付与しない。

## manifest と検索 API の整合性

manifest の各 archive が持つ `query_revision` を、矩形分析の
`GET /v2/hypocenters` に `expected_revision` として全ページで送る。
途中で revision が変わった場合は部分結果を表示せず、manifest を一度だけ更新して
論理 archive ID を再対応付けしたうえで最初から再取得する。
