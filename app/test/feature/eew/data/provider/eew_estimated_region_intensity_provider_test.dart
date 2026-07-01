import 'package:eqmonitor/core/extension/double_to_jma_forecast_intensity.dart';
import 'package:flutter_test/flutter_test.dart';

// _lookupSWaveTravelTime はファイルプライベートなので、
// 同等のロジックを public helper として切り出してテスト可能にするか、
// Provider 統合テストで検証する。
// ここでは EstimatedIntensityDataSource のロジックが正しく動くことを
// 既存テストに委ね、Provider の統合動作はウィジェットテストで検証する方針。

void main() {
  group('EewEstimatedRegion model', () {
    test('intensity < -0.5 gives null jmaIntensity', () {
      // JmaIntensityDouble extension のテスト
      // 既存の double_to_jma_forecast_intensity.dart のロジック確認
      expect((-1.0).toJmaIntensity, isNull); // < -0.5 → null
      expect(0.3.toJmaIntensity, isNotNull); // >= -0.5 → JmaIntensity.zero
    });
  });
}
