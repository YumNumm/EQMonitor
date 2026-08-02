import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/logic/eew_map_focus_bounds_builder.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_state.dart';
import 'package:eqmonitor/feature/home/data/model/map_camera_state.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/home/data/notifier/eew_map_focus.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/service/home_map_camera_coordinator.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_camera_state_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeMapCameraState extends _$HomeMapCameraState {
  @override
  MapCameraState build() {
    ref.listen(eewAliveTelegramProvider, (_, _) async {
      await handleRealtimeTransition();
    });
    ref.listen(shakeDetectionProvider, (_, _) async {
      await handleRealtimeTransition();
    });
    // 表示対象（期限切れ除外・デバッグ挿入込み）の増減もカメラ遷移の契機となる。
    // 1秒ごとの ticker で再計算されるため、イベント構成が変わったときのみ扱う。
    ref.listen(shakeDetectionVisibleProvider, (previous, next) async {
      final isSameEvents = const ListEquality<String>().equals(
        previous?.map((event) => event.eventId).toList(),
        next.map((event) => event.eventId).toList(),
      );
      if (isSameEvents) {
        return;
      }
      await handleRealtimeTransition();
    });

    return MapCameraState.home();
  }

  Future<void> handleRealtimeTransition() async {
    final eews =
        ref.read(eewAliveTelegramProvider) ?? const <EewTelegramItem>[];
    final focusNotifier = ref.read(eewMapFocusProvider.notifier);
    if (eews.isNotEmpty) {
      await applyEewFocus(
        decision: focusNotifier.sync(),
        ignoreAutoZoom: false,
      );
      return;
    }
    // 生存 EEW が無くなった時点でフォーカス状態を破棄する。
    focusNotifier.sync();

    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .handleRealtimeTransition(
          home: ref.read(homeConfigurationProvider.future),
          eews: const [],
          shakes: ref.read(shakeDetectionVisibleProvider),
        );
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
  }

  Future<void> setController({
    required MapController controller,
    required Size viewportSize,
  }) async {
    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .setController(
          controller: controller,
          viewportSize: viewportSize,
          home: ref.read(homeConfigurationProvider.future),
          eews: const [],
          shakes: const [],
          applyInitialFocus: false,
          isAtHome: false,
        );
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
    // remount では MapController が作り直され、カメラも初期状態に戻るため、
    // 差分同期ではなく EEW フォーカスを再適用する。
    final eews =
        ref.read(eewAliveTelegramProvider) ?? const <EewTelegramItem>[];
    if (eews.isNotEmpty) {
      final decision = ref.read(eewMapFocusProvider.notifier).refocus();
      await applyEewFocus(decision: decision, ignoreAutoZoom: false);
      return;
    }
    await handleRealtimeTransition();
  }

  /// マップ(Widget)の破棄時に呼び出し、保持中の [MapController] をクリアする。
  void clearController({required MapController controller}) {
    ref
        .read(homeMapCameraCoordinatorProvider)
        .clearController(controller: controller);
  }

  Future<void> returnToHome() async {
    final eews =
        ref.read(eewAliveTelegramProvider) ?? const <EewTelegramItem>[];
    if (eews.isNotEmpty) {
      final decision = ref.read(eewMapFocusProvider.notifier).refocus();
      // 震源も相関揺れも無い（PLUM 等）場合はフォーカス対象が作れないため、
      // 通常のホーム復帰へフォールバックする。
      if (decision.shouldFit) {
        await applyEewFocus(decision: decision, ignoreAutoZoom: true);
        return;
      }
    }

    final isAtHome = await ref
        .read(homeMapCameraCoordinatorProvider)
        .returnToHome(home: ref.read(homeConfigurationProvider.future));
    if (isAtHome != null) {
      state = state.copyWith(isAtHome: isAtHome);
    }
  }

  Future<void> applyEewFocus({
    required EewMapFocusDecision decision,
    required bool ignoreAutoZoom,
  }) async {
    if (!decision.shouldFit) {
      return;
    }
    final focusedEventId = decision.state.focusedEventId;
    final focused = focusedEventId == null
        ? null
        : (ref.read(eewAliveTelegramProvider) ?? const <EewTelegramItem>[])
              .where((eew) => eew.eventId == focusedEventId)
              .firstOrNull;
    if (focused == null) {
      return;
    }

    final configuration = await ref.read(homeConfigurationProvider.future);
    final bounds = ref
        .read(eewMapFocusBoundsBuilderProvider)
        .boundsForFocus(
          hypocenter: decision.targetHypocenter,
          shakeRect: decision.targetShakeRect,
          fallbackBounds: lngLatBoundsForHomeMapSettings(configuration.map),
        );
    if (bounds == null) {
      return;
    }

    final coordinator = ref.read(homeMapCameraCoordinatorProvider);
    final isAtHome = await coordinator.applyEewFocus(
      home: Future.value(configuration),
      bounds: bounds,
      generation: coordinator.nextCameraGeneration(),
      ignoreAutoZoom: ignoreAutoZoom,
    );
    // autoZoom 無効・世代不一致などで fit が実行されなかった場合は
    // 変化検知のベースラインを進めない。
    if (isAtHome == null) {
      return;
    }
    ref.read(eewMapFocusProvider.notifier).markApplied(decision: decision);
    state = state.copyWith(isAtHome: isAtHome);
  }
}
