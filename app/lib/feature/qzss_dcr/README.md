# QZSS災危通報機能

シリアルポート接続したGNSS受信機（u-blox製など）から、QZSS（みちびき）の災危通報（DCR: Disaster and Crisis Management Report）を受信・表示する機能です。

## 機能概要

- シリアルポート経由でGNSS受信機と接続
- UBX-RXM-SFRBXメッセージの自動受信
- NMEAセンテンス（$QZQSM）への変換
- 災危通報のデコードと表示

## 使い方

### 1. GNSS受信機の接続

- u-blox M10シリーズなどのGNSS受信機をUSB/シリアル接続
- 受信機がQZSS L1Sシグナルを受信できることを確認

### 2. アプリでの設定

1. `QzssDcrPage`を開く
2. 右上の設定アイコンをタップ
3. 利用可能なシリアルポートから受信機のポートを選択
4. ボーレートを選択（通常は115200 bps）
   - GR-M10-B/S-B45, GR-M10-RPは初期状態で9600または38400 bps
5. 「接続」ボタンをタップ

### 3. 災危通報の受信

- 接続後、GNSS受信機がQZSS衛星から災危通報を受信すると自動的に表示されます
- 表示される情報：
  - 災害カテゴリー（地震、津波、気象など）
  - 報告分類（通常、訓練、テスト）
  - 情報タイプ（発表、訂正、取消）
  - 衛星ID
  - 受信時刻
  - JMA情報（気象庁からの情報の場合）

## 技術仕様

### 対応プロトコル

- **UBXプロトコル**: u-blox社のバイナリプロトコル
- **NMEAセンテンス**: $QZQSM形式

### 対応衛星

| PRN | 衛星ID | 衛星名 |
|-----|--------|--------|
| 183 | 55     | QZS01  |
| 184 | 56     | QZS02  |
| 185 | 57     | QZS04  |
| 186 | 58     | QZS1R  |
| 189 | 61     | QZS03  |

### メッセージフォーマット

- UBX-RXM-SFRBX（ペイロード長: 44バイト）
- GNSS ID: 0x05（QZSS）
- メッセージタイプ: 43（JMA-DC Report）, 44（その他）

## アーキテクチャ

```
┌─────────────────────┐
│  GNSS受信機          │
│  (u-blox M10など)   │
└──────────┬──────────┘
           │ USB/シリアル
           │ UBX-RXM-SFRBX
┌──────────▼──────────┐
│ QzssSerialPortService │
│ - シリアルポート管理  │
│ - データ受信          │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  UbloxDecoder       │
│  (dart_azarashi)    │
│  UBX → NMEA変換      │
└──────────┬──────────┘
           │ $QZQSM
           ▼
┌─────────────────────┐
│  NmeaDecoder        │
│  (dart_azarashi)    │
│  NMEA → QzssDcReport │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  Riverpod Provider  │
│  - 接続状態管理      │
│  - レポート配信      │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  UI (Flutter)       │
│  - 設定画面          │
│  - 表示画面          │
└─────────────────────┘
```

## 依存パッケージ

- `libserialport_plus`: シリアルポート通信
- `dart_azarashi`: QZSS DCRデコーダー
- `riverpod`: 状態管理

## 参考資料

- [災危通報の解析 | prioris.jp/gnss](https://prioris.jp/gnss/docs/processing/qzqsm/)
- [IS-QZSS-DCR-010: ユーザインタフェース仕様書（災害・危機管理通報サービス）](https://qzss.go.jp/en/technical/download/pdf/ps-is-qzss/is-qzss-dcr-010.pdf)
- [nbtk/azarashi: QZSS DCR Decoder](https://github.com/nbtk/azarashi)

## 今後の拡張

- [ ] 災危通報の履歴表示
- [ ] 特定の災害カテゴリーでの通知
- [ ] ログファイルへの保存
- [ ] シミュレーションモード（テストデータの再生）
