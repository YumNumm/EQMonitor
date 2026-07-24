import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('VXSE61とVXSE62のラベルは電文の正式名称を返す', () {
    expect(EarthquakeTelegramType.vxse61.label, '顕著な地震の震源要素更新のお知らせ');
    expect(EarthquakeTelegramType.vxse62.label, '長周期地震動に関する観測情報');
  });
}
