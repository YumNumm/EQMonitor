import 'package:eqmonitor/feature/knet_waveform/ui/media/knet_movie_seekbar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets(
    'announces playback time and adjusts within the recording bounds',
    (
      tester,
    ) async {
      final changes = <Duration>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KnetMovieSeekbar(
              position: const Duration(seconds: 65),
              duration: const Duration(seconds: 70),
              onChanged: changes.add,
            ),
          ),
        ),
      );
      final semantics = tester.widget<Semantics>(
        find
            .ancestor(
              of: find.byType(M3ESeekbar),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(semantics.properties.slider, isTrue);
      expect(semantics.properties.value, '1分5秒');
      expect(semantics.properties.increasedValue, '1分10秒');
      expect(semantics.properties.decreasedValue, '0分55秒');
      semantics.properties.onIncrease?.call();
      semantics.properties.onDecrease?.call();
      expect(changes, [
        const Duration(seconds: 70),
        const Duration(seconds: 55),
      ]);
    },
  );

  testWidgets(
    'zero duration disables semantic adjustments and pointer seeking',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: KnetMovieSeekbar(
              position: Duration.zero,
              duration: Duration.zero,
              onChanged: (_) => fail('unavailable recording must not seek'),
            ),
          ),
        ),
      );
      final seekbar = tester.widget<M3ESeekbar>(find.byType(M3ESeekbar));
      expect(seekbar.enabled, isFalse);
      final semantics = tester.widget<Semantics>(
        find
            .ancestor(
              of: find.byType(M3ESeekbar),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(semantics.properties.onIncrease, isNull);
      expect(semantics.properties.onDecrease, isNull);
    },
  );
}
