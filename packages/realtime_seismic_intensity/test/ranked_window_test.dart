import 'dart:math';
import 'dart:typed_data';

import 'package:realtime_seismic_intensity/src/ranked_window.dart';
import 'package:test/test.dart';

void main() {
  test('窓に入れた値のうち k 番目に小さい値を返すこと（同じ値を含む）', () {
    final random = Random(3);
    final values = Float64List.fromList([
      for (var i = 0; i < 500; i++) (random.nextInt(50)).toDouble(),
    ]);
    final window = RankedWindow(values: values);
    for (var i = 0; i < 200; i++) {
      window.add(i);
    }
    for (var i = 0; i < 50; i++) {
      window.remove(i);
    }

    final inside = values.sublist(50, 200)..sort();
    for (final k in [1, 2, 30, 75, 150]) {
      expect(window.smallest(k), inside[k - 1], reason: 'k=$k');
    }
  });

  test('負の値は受け付けないこと', () {
    expect(
      () => RankedWindow(values: Float64List.fromList([1, -1])),
      throwsArgumentError,
    );
  });
}
