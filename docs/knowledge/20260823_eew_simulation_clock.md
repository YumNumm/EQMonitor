# EEWシミュレーションの時刻管理

## 原則

EEW履歴シミュレーションでは、報の切り替え、P波・S波到達予想円、EEWカードが
同じ再生経過時間を参照する。

- Widgetで `DateTime.now() - startedAt` を直接計算しない。
- pause時に累積再生時間を確定し、停止中は固定する。
- resume時は停止前の再生位置を維持し、実時計の基準時刻だけを更新する。
- 次報タイマーは報間隔全体ではなく、共通の再生位置から残り時間を計算する。
- 最終報到達後も再生位置を固定する。

## テスト

`clock` と `fake_async` を組み合わせ、実時間を待たずに停止・再開・終了を確認する。

```sh
cd app
mise exec -- flutter test --no-pub \
  test/feature/eew/data/eew_simulation_notifier_test.dart
```
