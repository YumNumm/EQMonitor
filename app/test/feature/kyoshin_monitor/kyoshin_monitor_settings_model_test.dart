import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

void main() {
  test('長周期データでは保存値が地下でも実効レイヤーは地表になる', () {
    const settings = KyoshinMonitorSettingsModel(
      realtimeDataType: RealtimeDataType.abrspmx,
      realtimeLayer: RealtimeLayer.underground,
    );

    expect(settings.effectiveRealtimeLayer, RealtimeLayer.surface);
    expect(settings.canSelectRealtimeLayer, isFalse);
  });

  test('通常データでは保存済みレイヤーを維持する', () {
    const settings = KyoshinMonitorSettingsModel(
      realtimeDataType: RealtimeDataType.shindo,
      realtimeLayer: RealtimeLayer.underground,
    );

    expect(settings.effectiveRealtimeLayer, RealtimeLayer.underground);
    expect(settings.canSelectRealtimeLayer, isTrue);
  });

  test('モニター無効時はレイヤーを選択できない', () {
    const settings = KyoshinMonitorSettingsModel(useKmoni: false);

    expect(settings.canSelectRealtimeLayer, isFalse);
  });
}
