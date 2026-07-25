import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/station_icon_image_expression.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const full = ['get', 'iconIdFull'];
  const plain = ['get', 'iconIdPlain'];
  const maxOnly = [
    'case',
    ['get', 'isMax'],
    full,
    plain,
  ];

  test('auto はズーム step 式で切り替える', () {
    expect(
      stationIconImageExpression(
        stationDisplayMode: StationDisplayMode.auto,
        stationTextZoom: 9,
      ),
      [
        'step',
        ['zoom'],
        maxOnly,
        9.0,
        full,
      ],
    );
  });

  test('maxFocused は isMax 分岐のみ', () {
    expect(
      stationIconImageExpression(
        stationDisplayMode: StationDisplayMode.maxFocused,
        stationTextZoom: 9,
      ),
      maxOnly,
    );
  });

  test('normal は常に数字入り', () {
    expect(
      stationIconImageExpression(
        stationDisplayMode: StationDisplayMode.normal,
        stationTextZoom: 9,
      ),
      full,
    );
  });

  test('allMinimized は常に色のみ', () {
    expect(
      stationIconImageExpression(
        stationDisplayMode: StationDisplayMode.allMinimized,
        stationTextZoom: 9,
      ),
      plain,
    );
  });
}
