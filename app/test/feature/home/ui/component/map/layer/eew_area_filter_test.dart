import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:test/test.dart';

void main() {
  const builder = EewAreaFilterBuilder();

  group('EewAreaFilterBuilder.build', () {
    test('codes が空の場合は空表示フィルターを返す', () {
      expect(builder.build([]), ['==', '1', '2']);
    });

    test('codes がある場合は code フィールドの in フィルターを返す', () {
      expect(builder.build(['210', '220']), [
        'in',
        ['get', 'code'],
        [
          'literal',
          ['210', '220'],
        ],
      ]);
    });
  });
}
