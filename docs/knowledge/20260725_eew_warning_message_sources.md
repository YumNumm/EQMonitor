# 緊急地震速報警報メッセージの backend 生成経路

調査日: 2026-07-25
backend submodule: `9ee6cd394d94bda7f0ac9326d120f6d47dbad733`

## 用途別の文面

backend には、用途が異なる3種類の文面がある。アプリ内警報 overlay の文面を検討する時は、
通知 push の完成文字列ではなく、構造が最も近い Live Activity の生成規則を参照する。

### 警報専用 push

`backend/service/notification-resolver/src/handlers/eew/warning/payload-builder.ts`

- title: `[緊急地震速報 警報] {hypocenterName}で地震 強い揺れに警戒!`
- body: `[警報地域]: {都道府県名を半角スペースで連結}`
- data: `type=EEW_WARNING`、`eventId`、`serialNo`

期待値は同ディレクトリの `__tests__/payload-builder.test.ts` で確認できる。

### Live Activity

`backend/packages/notification-message/src/eew/content-state.ts` と
`backend/packages/i18n/locales/ja/eew.json`

- 通常: `{hypocenterReduceName}で地震 {warningZones}で強い揺れ`
- PLUM 法・レベル法・震源不明: `{warningZones}で強い揺れ`
- 旧形式で `isWarning && hasWarningZones` だが地域配列なし、震源あり:
  `{hypocenterReduceName}で強い揺れ`
- 同じ旧形式で震源もなし: `強い揺れに警戒`

実際の文字列は半角スペースで結ばれ、改行を含まない。アプリ内 overlay では構造化された
2要素を別行に描画し、`○○で地震` と `△△ □□で強い揺れ` を強調する。現形式で
`hasWarningZones == false` の場合は backend 上では予報側の見出しへ進むため、上記の
`強い揺れに警戒` は一般的な欠損 fallback ではない。

### 通常の EEW push

`backend/packages/notification-message/src/eew/payload.ts`

- warning title: `🚨緊急地震速報(警報) {event.headline}`
- body: 最大予想震度、現在地域の予想震度、headline、報数・M・深さ・時刻を改行して構成

resolver の代表的な期待値は
`backend/service/notification-resolver/test/resolver/payload-builder.test.ts` にある。

## overlay 実装で再利用する規則

- 完成した通知文字列を空白や語尾で分割しない
- backend の短縮震源名 `hypocenterReduceName` と警報地域 `warningZones` から UI 用モデルを作る
- アプリでは短縮震源名を `hypocenter?.detailedName ?? hypocenter?.name`、警報地域を
  現在報の `warning.zones` 全件から得る
- 警報地域は半角スペース区切りでまとめ、「で強い揺れ」は末尾に1回だけ付ける
- アプリモデルにない backend の `isLevel` 相当は
  `accuracy?.epicenter == 1 && originTime == null` から導出する
- `isPlum` / `isLevel` 相当または震源不明時は、推定できない震源名を主見出しにしない
- `isWarning`、現在地の予想最大震度、到達情報は構造化フィールドから判定する
- overlay では情報不足時に内容を捏造せず、独自の最終 fallback を `強い揺れに警戒` とする

## 2026-08-17 追記: 現在警報と区域コード

- `hadWarning` は現在報の警報状態ではなく、DMData の
  `kind.lastKind.code == '31'`、つまり前回報ですでに警報だったかを示す。
- 初回警報と後続報で新たに追加された区域は `hadWarning == false` になり得るため、
  現在警報の抽出条件に使わない。
- `areaForecastLocalEew` は `warning.prefectures`（90xx）と対応する。
- `areaForecastLocalE` は `warning.regions`（3桁）および
  `forecastIntensity.regions` と対応する。
- 現在警報は `isWarning == true && !isCanceled` と現在報の警報配列で判定する。

詳細は
[`2026-08-17-eew-warning-area-mapping-design.md`](../superpowers/specs/2026-08-17-eew-warning-area-mapping-design.md)
を参照する。

## backend 経路

- dmdata 変換: `backend/service/dmdata-websocket-proxy/src/event-transformer.ts`
- message 生成: `backend/service/notification-resolver/src/handlers/eew/message-generator.ts`
- 警報専用 handler: `backend/service/notification-resolver/src/handlers/eew/warning/handler.ts`
- resolver entry: `backend/service/notification-resolver/src/index.ts`

## 調査時に見つかった注意点

これは overlay の変更対象ではないが、backend の文面を仕様として再利用する際は次を前提に
しないこと。

- 警報専用 push の都道府県 query には明示的な順序指定がなく、地域順は保証されない
- 都道府県が0件の場合は body の地域部分が空になる
- 震源名欠如時、警報専用 title は震源部分が空の
  `[緊急地震速報 警報] で地震 強い揺れに警戒!` になる
- 警報専用 handler の SQL 自体は `had_warning` を filter していない
- 通常通知対象が0件かつ EEW `serialNo <= 1` の時は、早期 return が警報専用経路にも影響する
- 旧設計書の震源名は `detailed.name ?? name` だが、警報専用 push 実装は
  `event.hypocenter?.name ?? ''` を使用する

したがって overlay は backend の最終文字列をコピーせず、アプリが受信した構造化 EEW と
現在地域から、欠損を明示的に扱って表示モデルを作る。

## 再調査用コマンド

```bash
git -C backend rev-parse HEAD
rg -n "強い揺れ|EEW_WARNING|hypocenterReduceName|warningZones" \
  backend/packages/notification-message \
  backend/service/notification-resolver/src/handlers/eew
```
