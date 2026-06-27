import 'package:core/core.dart' show Date;
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EewListParameter.isFiltering', () {
    test('デフォルトでは false', () {
      expect(const EewListParameter().isFiltering, isFalse);
    });
    test('いずれかの条件が設定されると true', () {
      expect(
        const EewListParameter(magnitudeGte: 5).isFiltering,
        isTrue,
      );
    });
  });

  group('EewListParameter.toQuery', () {
    test('空パラメータでは limit と cursor 以外は null', () {
      final q = const EewListParameter().toQuery(cursor: null, limit: 10);
      expect(q.limit, '10');
      expect(q.cursor, isNull);
      expect(q.magnitudeGte, isNull);
      expect(q.intensityGte, isNull);
      expect(q.isWarning, isNull);
    });

    test('各フィルタが文字列・APIenumに変換される', () {
      const originGte = Date(year: 2026, month: 6, day: 1);
      final q = const EewListParameter(
        magnitudeGte: 4.5,
        depthLte: 100,
        intensityGte: JmaIntensity.fiveLower,
        originTimeGte: originGte,
        isWarning: true,
      ).toQuery(cursor: 'c1', limit: 50);

      expect(q.limit, '50');
      expect(q.cursor, 'c1');
      expect(q.magnitudeGte, '4.5');
      expect(q.depthLte, '100');
      expect(q.intensityGte, JmaIntensity.fiveLower.toApiJmaIntensity);
      expect(q.originTimeGte, originGte.toString());
      expect(q.isWarning, 'true');
    });
  });

  group('EewListParameter update', () {
    test('updateMagnitude は初期値(0,9)で null に戻す想定の値も保持する', () {
      final p = const EewListParameter().updateMagnitude(4, 7);
      expect(p.magnitudeGte, 4);
      expect(p.magnitudeLte, 7);
    });
    test('updateIsWarning(false) は null 化(全件表示)', () {
      final p = const EewListParameter(isWarning: true).updateIsWarning(value: false);
      expect(p.isWarning, isNull);
    });
    test('updateIsWarning(true) は true', () {
      final p = const EewListParameter().updateIsWarning(value: true);
      expect(p.isWarning, isTrue);
    });
  });
}
