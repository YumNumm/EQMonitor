import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage_owner.dart';
import 'package:eqmonitor_map/src/renderer/base_map_overlay_frame_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';
import 'package:flutter/foundation.dart';

typedef SubmitBaseMapOverlayFrame = void Function(
  MapSceneFrameSubmission submission,
);

/// Scene submit中だけ候補resourceを公開し、成功後にactive化するstage。
abstract interface class BaseMapOverlayFrameResourceStage {
  void beginSubmission();

  void commit();

  void rollback();
}

sealed class BaseMapOverlayFrameCommitResult {
  const BaseMapOverlayFrameCommitResult();
}

final class BaseMapOverlayFrameCommitSucceeded
    extends BaseMapOverlayFrameCommitResult {
  const BaseMapOverlayFrameCommitSucceeded();
}

final class BaseMapOverlayFrameCommitFailed
    extends BaseMapOverlayFrameCommitResult {
  const BaseMapOverlayFrameCommitFailed({
    required this.error,
    required this.stackTrace,
    required this.fallbackError,
  });

  final Object error;
  final StackTrace stackTrace;
  final Object? fallbackError;
}

/// Scene成功後にだけoverlay stateとcoverageをまとめて進めるowner。
final class BaseMapOverlayFrameOwner {
  BaseMapOverlayFrameOwner({
    ValueChanged<EarthquakeOverlayCoverage>? onCoverageChanged,
  }) : _coverage = EarthquakeOverlayCoverageOwner(
         onChanged: onCoverageChanged,
       );

  final EarthquakeOverlayCoverageOwner _coverage;
  EarthquakeMapOverlaySnapshot? _overlay;
  ObservationPointBatch? _previousObservationBatch;

  EarthquakeMapOverlaySnapshot? get overlay => _overlay;
  ObservationPointBatch? get previousObservationBatch =>
      _previousObservationBatch;
  EarthquakeOverlayCoverage get coverage => _coverage.coverage;

  void updateCoverageCallback(
    ValueChanged<EarthquakeOverlayCoverage>? onCoverageChanged,
  ) => _coverage.onChanged = onCoverageChanged;

  void hide() => _coverage.hide();

  BaseMapOverlayFrameCommitResult commit({
    required BaseMapOverlayFrameResult candidate,
    required MapSceneFrameSubmission baseOnlySubmission,
    required BaseMapOverlayFrameResourceStage? resources,
    required SubmitBaseMapOverlayFrame submitFrame,
    required VoidCallback retireAllGpuResources,
    required VoidCallback failClosedResources,
  }) {
    final submission = candidate.submission;
    if (submission == null) {
      throw ArgumentError.value(candidate, 'candidate', 'has no submission');
    }
    try {
      resources?.beginSubmission();
      submitFrame(submission);
      resources?.commit();
    } on Object catch (error, stackTrace) {
      resources?.rollback();
      Object? fallbackError;
      if (!identical(submission, baseOnlySubmission)) {
        try {
          submitFrame(baseOnlySubmission);
        } on Object catch (error) {
          fallbackError = error;
          retireAllGpuResources();
        }
      } else {
        fallbackError = error;
        retireAllGpuResources();
      }
      failClosedResources();
      _overlay = null;
      _previousObservationBatch = null;
      _coverage.hide();
      return BaseMapOverlayFrameCommitFailed(
        error: error,
        stackTrace: stackTrace,
        fallbackError: fallbackError,
      );
    }
    _overlay = candidate.overlay;
    _previousObservationBatch = candidate.observationBatchForReuse;
    _coverage.publish(candidate.coverage);
    return const BaseMapOverlayFrameCommitSucceeded();
  }
}
