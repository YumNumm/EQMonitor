# iOS native slim `jma_code_table.json` はリポジトリにコミットする

## 結論

AppIntent / Widget 用の slim JSON（prefecture + city のみ、約 700KB）は
`app/assets/parameters/jma_code_table.json` として **git にコミットする**。
フル Asset Pack（pmtiles 等）は従来どおりコミットしない。

## 理由

- clone / clean 直後に `stage_from_r2.sh --target all` を通していないと
  Xcode Copy Bundle Resources が欠落ファイルで失敗する
- slim は静的マスタに近く、`jma_map.pb`（約 9MB）より小さい
- 正本は引き続き R2 の署名済み Pack。CI の stage で上書き追従できる

## 運用

```bash
# ローカル iOS ビルド: 通常は不要（コミット済み）
# R2 の Pack 更新後に slim を揃えたいとき / CI build-ios:
tool/asset_pack/stage_from_r2.sh --target all
```

差分が出たらコミットする。

## 関連

- `docs/asset-pack-cd.md`
- `docs/todo/850_ios_missing_jma_code_table_json_build_break.md`
