import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/logic/eew_map_focus_bounds_builder.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_grid_rect.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_state.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_map_focus_transition.g.dart';

@riverpod
EewMapFocusTransition eewMapFocusTransition(Ref ref) => EewMapFocusTransition(
  boundsBuilder: ref.watch(eewMapFocusBoundsBuilderProvider),
);

class EewMapFocusTransition {
  const EewMapFocusTransition({required this.boundsBuilder});

  final EewMapFocusBoundsBuilder boundsBuilder;

  EewMapFocusDecision evaluate({
    required EewMapFocusState previous,
    required List<EewTelegramItem> aliveEews,
    required List<ShakeDetectionEvent> allShakes,
  }) {
    final latestEew = latestAliveEew(aliveEews: aliveEews);
    if (latestEew == null) {
      return const EewMapFocusDecision(
        state: EewMapFocusState(),
        shouldFit: false,
      );
    }

    final shakeBoundsByEventId = accumulateShakeBoundsByEventId(
      previous: previous,
      aliveEews: aliveEews,
      allShakes: allShakes,
    );
    final targetHypocenter = hypocenterOf(eew: latestEew);
    final targetShakeRect = shakeBoundsByEventId[latestEew.eventId];
    final isNewTarget = latestEew.eventId != previous.focusedEventId;
    final state = previous.copyWith(
      focusedEventId: latestEew.eventId,
      focusedHypocenter: targetHypocenter,
      isFocused: isNewTarget ? true : previous.isFocused,
      shakeBoundsByEventId: shakeBoundsByEventId,
    );
    // fit 済みの対象（applied*）と比較する。fit が実行されなかった場合は
    // applied* が進まないため、次回の変化通知で再試行できる。
    final didTargetChange =
        previous.appliedEventId != latestEew.eventId ||
        previous.appliedHypocenter != targetHypocenter ||
        previous.appliedShakeRect != targetShakeRect;
    return EewMapFocusDecision(
      state: state,
      shouldFit:
          state.isFocused &&
          didTargetChange &&
          canFit(hypocenter: targetHypocenter, shakeRect: targetShakeRect),
      targetHypocenter: targetHypocenter,
      targetShakeRect: targetShakeRect,
    );
  }

  EewMapFocusState clearFocus({required EewMapFocusState previous}) =>
      previous.copyWith(isFocused: false);

  EewMapFocusDecision refocus({
    required EewMapFocusState previous,
    required List<EewTelegramItem> aliveEews,
    required List<ShakeDetectionEvent> allShakes,
  }) => evaluate(
    previous: previous.copyWith(
      focusedEventId: null,
      focusedHypocenter: null,
      isFocused: false,
      appliedEventId: null,
      appliedHypocenter: null,
      appliedShakeRect: null,
    ),
    aliveEews: aliveEews,
    allShakes: allShakes,
  );

  /// カメラ fit が実際に完了したときのみ、変化検知のベースラインを進める。
  EewMapFocusState markApplied({
    required EewMapFocusState previous,
    required EewMapFocusDecision decision,
  }) {
    final appliedEventId = decision.state.focusedEventId;
    return appliedEventId == null || appliedEventId != previous.focusedEventId
        ? previous
        : previous.copyWith(
            appliedEventId: appliedEventId,
            appliedHypocenter: decision.targetHypocenter,
            appliedShakeRect: decision.targetShakeRect,
          );
  }

  EewTelegramItem? latestAliveEew({required List<EewTelegramItem> aliveEews}) =>
      aliveEews.fold<EewTelegramItem?>(
        null,
        (latest, eew) =>
            latest == null || eew.reportTime.isAfter(latest.reportTime)
            ? eew
            : latest,
      );

  Map<String, EewMapFocusGridRect> accumulateShakeBoundsByEventId({
    required EewMapFocusState previous,
    required List<EewTelegramItem> aliveEews,
    required List<ShakeDetectionEvent> allShakes,
  }) {
    final aliveEventIds = aliveEews.map((eew) => eew.eventId).toSet();
    return {
      for (final eew in aliveEews)
        if (shakeBoundsForEventId(
              eventId: eew.eventId,
              previousBounds: aliveEventIds.contains(eew.eventId)
                  ? previous.shakeBoundsByEventId[eew.eventId]
                  : null,
              allShakes: allShakes,
            )
            case final bounds?)
          eew.eventId: bounds,
    };
  }

  EewMapFocusGridRect? shakeBoundsForEventId({
    required String eventId,
    required EewMapFocusGridRect? previousBounds,
    required List<ShakeDetectionEvent> allShakes,
  }) {
    final currentBounds = boundsBuilder.mergeShakeEvents(
      shakes: allShakes
          .where((shake) => shake.correlatedEewEventId == eventId)
          .toList(),
    );
    return switch ((previousBounds, currentBounds)) {
      (null, null) => null,
      (final bounds?, null) => bounds,
      (null, final bounds?) => bounds,
      (final previous?, final current?) => boundsBuilder.union(
        a: previous,
        b: current,
      ),
    };
  }

  ({double latitude, double longitude})? hypocenterOf({
    required EewTelegramItem eew,
  }) {
    final hypocenter = eew.hypocenter;
    final latitude = hypocenter?.latitude;
    final longitude = hypocenter?.longitude;
    return latitude == null || longitude == null
        ? null
        : (latitude: latitude, longitude: longitude);
  }

  bool canFit({
    required ({double latitude, double longitude})? hypocenter,
    required EewMapFocusGridRect? shakeRect,
  }) =>
      boundsBuilder.boundsForFocus(
        hypocenter: hypocenter,
        shakeRect: shakeRect,
        fallbackBounds: const LngLatBounds(
          longitudeWest: 120,
          longitudeEast: 150,
          latitudeSouth: 20,
          latitudeNorth: 50,
        ),
      ) !=
      null;
}
