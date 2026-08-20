import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/renderer/map_render_lifecycle_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mapAppLifecycleFor', () {
    test('treats the pre-notification null state as active', () {
      // 起動直後に描画を止めると初回frameが出ない。
      expect(mapAppLifecycleFor(null), MapAppLifecycle.active);
    });

    test('maps every Flutter state', () {
      expect(
        AppLifecycleState.values.map(mapAppLifecycleFor),
        [
          // Flutterの宣言順に依存しないよう、値と対応で確認する。
          for (final state in AppLifecycleState.values)
            switch (state) {
              AppLifecycleState.resumed => MapAppLifecycle.active,
              AppLifecycleState.inactive => MapAppLifecycle.inactive,
              AppLifecycleState.hidden ||
              AppLifecycleState.paused => MapAppLifecycle.background,
              AppLifecycleState.detached => MapAppLifecycle.detached,
            },
        ],
      );
    });

    test('hidden and paused both mean the surface may be gone', () {
      expect(
        mapAppLifecycleFor(AppLifecycleState.hidden),
        MapAppLifecycle.background,
      );
      expect(
        mapAppLifecycleFor(AppLifecycleState.paused),
        MapAppLifecycle.background,
      );
    });

    test('inactive keeps the surface alive', () {
      expect(
        mapAppLifecycleFor(AppLifecycleState.inactive),
        MapAppLifecycle.inactive,
      );
    });
  });

  group('suspendsMapRendering', () {
    test('suspends only in background and detached', () {
      expect(suspendsMapRendering(MapAppLifecycle.active), isFalse);
      expect(suspendsMapRendering(MapAppLifecycle.inactive), isFalse);
      expect(suspendsMapRendering(MapAppLifecycle.background), isTrue);
      expect(suspendsMapRendering(MapAppLifecycle.detached), isTrue);
    });
  });

  group('retiresGpuResourcesOnTransition', () {
    test('retires when entering background or detached', () {
      expect(
        retiresGpuResourcesOnTransition(
          from: MapAppLifecycle.active,
          to: MapAppLifecycle.background,
        ),
        isTrue,
      );
      expect(
        retiresGpuResourcesOnTransition(
          from: MapAppLifecycle.inactive,
          to: MapAppLifecycle.detached,
        ),
        isTrue,
      );
    });

    test('does not retire when only becoming inactive', () {
      // 通知シェードを引くたびに全tileを捨てて再uploadしない。
      expect(
        retiresGpuResourcesOnTransition(
          from: MapAppLifecycle.active,
          to: MapAppLifecycle.inactive,
        ),
        isFalse,
      );
    });

    test('does not retire on resume', () {
      expect(
        retiresGpuResourcesOnTransition(
          from: MapAppLifecycle.background,
          to: MapAppLifecycle.active,
        ),
        isFalse,
      );
    });

    test('is a no-op when the lifecycle did not change', () {
      for (final lifecycle in MapAppLifecycle.values) {
        expect(
          retiresGpuResourcesOnTransition(from: lifecycle, to: lifecycle),
          isFalse,
          reason: '$lifecycle',
        );
      }
    });
  });

  group('advancesGpuContextGenerationOnTransition', () {
    test('advances when resuming from background or detached', () {
      expect(
        advancesGpuContextGenerationOnTransition(
          from: MapAppLifecycle.background,
          to: MapAppLifecycle.active,
        ),
        isTrue,
      );
      expect(
        advancesGpuContextGenerationOnTransition(
          from: MapAppLifecycle.detached,
          to: MapAppLifecycle.inactive,
        ),
        isTrue,
      );
    });

    test('does not advance on the inactive round trip', () {
      expect(
        advancesGpuContextGenerationOnTransition(
          from: MapAppLifecycle.inactive,
          to: MapAppLifecycle.active,
        ),
        isFalse,
      );
      expect(
        advancesGpuContextGenerationOnTransition(
          from: MapAppLifecycle.active,
          to: MapAppLifecycle.inactive,
        ),
        isFalse,
      );
    });

    test('does not advance when going into the background', () {
      expect(
        advancesGpuContextGenerationOnTransition(
          from: MapAppLifecycle.active,
          to: MapAppLifecycle.background,
        ),
        isFalse,
      );
    });

    test('does not advance between the two suspended states', () {
      // background→detachedはどちらもGPUを持っていないので世代を進めない。
      expect(
        advancesGpuContextGenerationOnTransition(
          from: MapAppLifecycle.background,
          to: MapAppLifecycle.detached,
        ),
        isFalse,
      );
    });

    test('retire and advance never fire on the same transition', () {
      for (final from in MapAppLifecycle.values) {
        for (final to in MapAppLifecycle.values) {
          final retires = retiresGpuResourcesOnTransition(from: from, to: to);
          final advances = advancesGpuContextGenerationOnTransition(
            from: from,
            to: to,
          );
          expect(retires && advances, isFalse, reason: '$from -> $to');
        }
      }
    });
  });
}
