import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_image_request_resolver.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

void main() {
  const resolver = KyoshinMonitorImageRequestResolver();

  test('長周期データでは保存値が地下でも画像レイヤーは地表になる', () {
    const settings = KyoshinMonitorSettingsModel(
      realtimeDataType: RealtimeDataType.abrspmx,
      realtimeLayer: RealtimeLayer.underground,
    );
    final request = resolver.resolve(settings);

    expect(request.layer, RealtimeLayer.surface);
    expect(request.canSelectRealtimeLayer, isFalse);
  });

  test('通常データでは保存済みレイヤーを維持する', () {
    const settings = KyoshinMonitorSettingsModel(
      realtimeDataType: RealtimeDataType.shindo,
      realtimeLayer: RealtimeLayer.underground,
    );
    final request = resolver.resolve(settings);

    expect(request.layer, RealtimeLayer.underground);
    expect(request.canSelectRealtimeLayer, isTrue);
  });

  test('モニター無効時はレイヤーを選択できない', () {
    const settings = KyoshinMonitorSettingsModel(useKmoni: false);
    final request = resolver.resolve(settings);

    expect(request.canSelectRealtimeLayer, isFalse);
  });

  group('imageSource', () {
    test('LPGM系列ならソース設定がkmoniでもlmoniから取得する', () {
      const settings = KyoshinMonitorSettingsModel(
        monitorSource: KyoshinMonitorSource.kmoni,
        realtimeDataType: RealtimeDataType.abrsp2s,
      );

      expect(resolver.resolve(settings).source, KyoshinMonitorSource.lmoni);
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

      expect(resolver.resolve(kmoni).source, KyoshinMonitorSource.kmoni);
      expect(resolver.resolve(lmoni).source, KyoshinMonitorSource.lmoni);
    });
  });

  group('delayProfile', () {
    test('LPGM系列はlpgmプロファイル', () {
      for (final type in RealtimeDataType.values.where((e) => e.isLpgm)) {
        final settings = KyoshinMonitorSettingsModel(
          monitorSource: KyoshinMonitorSource.lmoni,
          realtimeDataType: type,
        );
        expect(
          resolver.resolve(settings).delayProfile,
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

      expect(
        resolver.resolve(settings).delayProfile,
        KyoshinMonitorDelayProfile.kmoni,
      );
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

      expect(resolver.resolve(lpgm).source, resolver.resolve(shindo).source);
      expect(
        resolver.resolve(lpgm).delayProfile,
        isNot(resolver.resolve(shindo).delayProfile),
      );
    });
  });
}
