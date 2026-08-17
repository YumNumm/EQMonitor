import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_sample.dart';

final class MapPerformanceEvent {
  const new _({
    required this.frameSequence,
    required this.sample,
    required this.fixtureId,
    required this.nodeKey,
    required this.operationId,
  });

  final int frameSequence;
  final MapPerformanceSample sample;
  final String? fixtureId;
  final String? nodeKey;
  final String? operationId;

  MapPerformanceSchemaVersion get schemaVersion => sample.schemaVersion;

  MapClockDomainId get clockDomain => sample.clockDomain;
}

MapPerformanceEvent createMapPerformanceEvent({
  required int frameSequence,
  required MapPerformanceSample sample,
  String? fixtureId,
  String? nodeKey,
  String? operationId,
}) {
  if (frameSequence < 0) {
    throw ArgumentError.value(
      frameSequence,
      'frameSequence',
      'must not be negative',
    );
  }
  if (fixtureId != null && fixtureId.trim().isEmpty) {
    throw ArgumentError.value(fixtureId, 'fixtureId', 'must not be blank');
  }
  if (nodeKey != null && nodeKey.trim().isEmpty) {
    throw ArgumentError.value(nodeKey, 'nodeKey', 'must not be blank');
  }
  if (operationId != null && operationId.trim().isEmpty) {
    throw ArgumentError.value(operationId, 'operationId', 'must not be blank');
  }

  return MapPerformanceEvent._(
    frameSequence: frameSequence,
    sample: sample,
    fixtureId: fixtureId,
    nodeKey: nodeKey,
    operationId: operationId,
  );
}
