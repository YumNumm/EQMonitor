# Debug Replay時のEEW到達時刻のシフト

## ルール
- `feature/debug/replay/debug_replay_provider.dart` でEEWをリプレイ注入する際は、`reportTime` / `originTime` / `arrivalTime` だけでなく、`forecastIntensity.regions[].arrivalTime.value` も同じ `offset` でシフトする。
- 上記を行わないと、カード上の「主要動到達まで/到達済み」判定が過去時刻基準になり、リプレイ再生時刻と表示が一致しない。

## 実装ポイント
- `item.forecastIntensity?.copyWith(regions: ...)` でリージョン配列を再構築し、各 `arrivalTime.value` に `add(offset)` を適用する。
- 既存イベントを再注入するケースでは、`hypocenter.magnitude` が欠損していた場合に既存EEWの値を補完することで、表示の欠落を避けられる。
