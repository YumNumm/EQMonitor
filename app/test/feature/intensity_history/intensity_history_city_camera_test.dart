import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_city_camera.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const camera = IntensityHistoryCityCamera();

  group('padding', () {
    test('縦画面ではシートの初期高さぶん下を空ける', () {
      final padding = camera.padding(
        viewportSize: const Size(400, 900),
        safePadding: const EdgeInsets.only(top: 50, bottom: 30),
      );

      expect(padding, const EdgeInsets.fromLTRB(24, 146, 24, 194));
    });

    test('横画面では右半分のシートぶん右を空ける', () {
      final padding = camera.padding(
        viewportSize: const Size(900, 400),
        safePadding: const EdgeInsets.only(top: 20, bottom: 10),
      );

      expect(padding, const EdgeInsets.fromLTRB(24, 116, 474, 34));
    });
  });

  group('maxZoomFrom', () {
    test('現在のズームが上限以下なら上限まで', () {
      expect(camera.maxZoomFrom(6), IntensityHistoryCityCamera.maxZoom);
      expect(camera.maxZoomFrom(null), IntensityHistoryCityCamera.maxZoom);
    });

    test('上限より拡大済みなら現在のズームを超えて寄らない', () {
      expect(camera.maxZoomFrom(13), 13);
    });
  });
}
