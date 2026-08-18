import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/service/kyoshin_monitor_delay_adjust_service.dart';
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

  group('effectiveMonitorSource', () {
    test('LPGM系列ならソース設定がkmoniでもlmoniから取得する', () {
      // LPGM系列は長周期地震動モニタにしか存在しない。
      const settings = KyoshinMonitorSettingsModel(
        monitorSource: KyoshinMonitorSource.kmoni,
        realtimeDataType: RealtimeDataType.abrsp2s,
      );

      expect(settings.effectiveMonitorSource, KyoshinMonitorSource.lmoni);
    });

    test('非LPGM系列ならソース設定に従う', () {
      const kmoni = KyoshinMonitorSettingsModel(
        monitorSource: KyoshinMonitorSource.kmoni,
        realtimeDataType: RealtimeDataType.shindo,
      );
      const lmoni = KyoshinMonitorSettingsModel(
        monitorSource: KyoshinMonitorSource.lmoni,
        realtimeDataType: RealtimeDataType.shindo,
      );

      expect(kmoni.effectiveMonitorSource, KyoshinMonitorSource.kmoni);
      expect(lmoni.effectiveMonitorSource, KyoshinMonitorSource.lmoni);
    });
  });

  group('delayProfile', () {
    // 公開遅延の学習単位はホストではなくパイプラインで決まる。
    // 長周期地震動モニタを選んでいても非LPGM系列は `/img_svr/` 経由で
    // 強震モニタのパイプラインから配信されるため、ホストで分けると
    // 0.66秒ぶん違う2つのパイプラインが1つの学習値を取り合ってしまう。
    test('LPGM系列はlpgmプロファイル', () {
      for (final type in RealtimeDataType.values.where((e) => e.isLpgm)) {
        final settings = KyoshinMonitorSettingsModel(
          monitorSource: KyoshinMonitorSource.lmoni,
          realtimeDataType: type,
        );
        expect(
          settings.delayProfile,
          KyoshinMonitorDelayProfile.lpgm,
          reason: type.name,
        );
      }
    });

    test('長周期地震動モニタでも非LPGM系列はkmoniプロファイル', () {
      const settings = KyoshinMonitorSettingsModel(
        monitorSource: KyoshinMonitorSource.lmoni,
        realtimeDataType: RealtimeDataType.shindo,
      );

      expect(settings.delayProfile, KyoshinMonitorDelayProfile.kmoni);
    });

    test('同じlmoniホストでも階級データと震度でプロファイルが分かれる', () {
      const lpgm = KyoshinMonitorSettingsModel(
        monitorSource: KyoshinMonitorSource.lmoni,
        realtimeDataType: RealtimeDataType.abrsp2s,
      );
      const shindo = KyoshinMonitorSettingsModel(
        monitorSource: KyoshinMonitorSource.lmoni,
        realtimeDataType: RealtimeDataType.shindo,
      );

      expect(lpgm.effectiveMonitorSource, shindo.effectiveMonitorSource);
      expect(lpgm.delayProfile, isNot(shindo.delayProfile));
    });
  });
}
