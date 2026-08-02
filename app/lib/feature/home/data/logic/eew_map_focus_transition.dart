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
    final latestHypocenter = hypocenterOf(eew: latestEew);
    final latestShakeBounds = shakeBoundsByEventId[latestEew.eventId];
    final state = previous.copyWith(
      focusedEventId: latestEew.eventId,
      isFocused: latestEew.eventId != previous.focusedEventId
          ? true
          : previous.isFocused,
      focusedHypocenter: latestHypocenter,
      shakeBoundsByEventId: shakeBoundsByEventId,
    );
    if (latestEew.eventId != previous.focusedEventId) {
      return EewMapFocusDecision(
        state: state,
        shouldFit: canFit(
          hypocenter: latestHypocenter,
          shakeRect: latestShakeBounds,
        ),
      );
    }

    if (!previous.isFocused) {
      return EewMapFocusDecision(state: state, shouldFit: false);
    }

    final didTargetChange =
        previous.focusedHypocenter != latestHypocenter ||
        previous.shakeBoundsByEventId[latestEew.eventId] != latestShakeBounds;
    return EewMapFocusDecision(
      state: state,
      shouldFit:
          didTargetChange &&
          canFit(hypocenter: latestHypocenter, shakeRect: latestShakeBounds),
    );
  }

  EewMapFocusState clearFocus({required EewMapFocusState previous}) =>
      previous.copyWith(isFocused: false);

  EewMapFocusDecision refocus({
    required EewMapFocusState previous,
    required List<EewTelegramItem> aliveEews,
    required List<ShakeDetectionEvent> allShakes,
  }) {
    final decision = evaluate(
      previous: previous.copyWith(focusedEventId: null, isFocused: false),
      aliveEews: aliveEews,
      allShakes: allShakes,
    );
    return decision.state.focusedEventId == null
        ? decision
        : EewMapFocusDecision(
            state: decision.state.copyWith(isFocused: true),
            shouldFit: decision.shouldFit,
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
