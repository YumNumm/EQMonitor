import 'dart:async';

import 'package:eqmonitor_map/src/flutter_scene/map_gpu_probe.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch.dart';
import 'package:flutter/foundation.dart';

typedef _MapSpriteTextureKey = (int, String);
typedef _MapSpriteTopologyKey = (int, int, int);
typedef _MapSpriteInstanceKey = (int, MapSpriteInstanceGeneration);

final class MapSpriteRendererLimits {
  const MapSpriteRendererLimits({
    required this.maxActiveAtlases,
    required this.maxTopologyVariants,
    required this.maxPolicyBatches,
  });

  final int maxActiveAtlases;
  final int maxTopologyVariants;
  final int maxPolicyBatches;
}

enum FlutterSceneSpriteResourceFailureReason {
  invalidLimits,
  frameMismatch,
  atlasLimitExceeded,
  topologyLimitExceeded,
  policyLimitExceeded,
  livePinLimitExceeded,
  shaderInterface,
  atlasUpload,
  topologyPrepare,
  instancePrepare,
  candidateState,
}

final class FlutterSceneSpriteResourceFailure implements Exception {
  const FlutterSceneSpriteResourceFailure({
    required this.reason,
    required this.message,
    this.stackTrace,
  });

  final FlutterSceneSpriteResourceFailureReason reason;
  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() =>
      'FlutterSceneSpriteResourceFailure('
      '${reason.name}, $message)';
}

typedef MapSpriteGpuCompletionBarrier = Future<void> Function();

abstract interface class FlutterSceneSpriteResourceBackend<
  TTexture,
  TTopology,
  TInstance
> {
  void preflightShaderInterface(MapPointSpriteInstanceBatch batch);

  TTexture uploadTexture(MapSpriteAtlas atlas);

  TTopology prepareTopology({
    required int spriteAbiVersion,
    required int materialVersion,
  });

  TInstance prepareInstance({
    required TTopology topology,
    required MapPointSpriteInstanceBatch batch,
  });

  void retireTexture(TTexture texture);

  void retireTopology(TTopology topology);

  void retireInstance(TInstance instance);
}

final class FlutterSceneSpritePreparedNode<TTexture, TTopology, TInstance> {
  const FlutterSceneSpritePreparedNode({
    required this.batch,
    required this.texture,
    required this.topology,
    required this.instance,
  });

  final MapPointSpriteInstanceBatch batch;
  final TTexture texture;
  final TTopology topology;
  final TInstance instance;
}

final class FlutterSceneSpritePreparedFrame<TTexture, TTopology, TInstance> {
  FlutterSceneSpritePreparedFrame._(this.owner, this._pins, this.nodes);

  final FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance> owner;
  final _MapSpriteFramePins<TTexture, TTopology, TInstance> _pins;
  final List<FlutterSceneSpritePreparedNode<TTexture, TTopology, TInstance>>
  nodes;
  var _isFinalized = false;

  bool get isFinalized => _isFinalized;

  void commit() => commitFlutterSceneSpritePreparedFrame(this);

  void rollback() => rollbackFlutterSceneSpritePreparedFrame(this);
}

/// Sprite resources are pinned per submitted frame and released after a fence.
final class FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance> {
  FlutterSceneSpriteResourceOwner({
    required this.limits,
    required this.maxFramesInFlight,
    required this.backend,
    required this.waitForGpuCompletion,
    this.probeRuntime,
    this.onCounterSnapshot,
  }) {
    if (maxFramesInFlight < 1 ||
        limits.maxActiveAtlases < 1 ||
        limits.maxTopologyVariants < 1 ||
        limits.maxPolicyBatches < 1) {
      throw const FlutterSceneSpriteResourceFailure(
        reason: FlutterSceneSpriteResourceFailureReason.invalidLimits,
        message: 'All caller limits must be positive.',
      );
    }
  }

  final MapSpriteRendererLimits limits;
  final int maxFramesInFlight;
  final FlutterSceneSpriteResourceBackend<TTexture, TTopology, TInstance>
  backend;
  final MapSpriteGpuCompletionBarrier waitForGpuCompletion;
  final MapGpuProbeRuntime? probeRuntime;
  final ValueChanged<MapGpuResourceCounterSnapshot>? onCounterSnapshot;

  final _textures =
      <
        _MapSpriteTextureKey,
        _MapSpriteResourceEntry<_MapSpriteTextureKey, TTexture>
      >{};
  final _topologies =
      <
        _MapSpriteTopologyKey,
        _MapSpriteResourceEntry<_MapSpriteTopologyKey, TTopology>
      >{};
  final _instances =
      <
        _MapSpriteInstanceKey,
        _MapSpriteResourceEntry<_MapSpriteInstanceKey, TInstance>
      >{};
  final _pending = <_MapSpritePendingFrame<TTexture, TTopology, TInstance>>[];
  _MapSpriteFramePins<TTexture, TTopology, TInstance>? _active;
  _MapSpriteFramePins<TTexture, TTopology, TInstance>? _candidate;
  final _MapGpuDebugResourceCounters? _debugCounters =
      mapGpuProbeCompileTimeEnabled ? _MapGpuDebugResourceCounters() : null;

  bool get hasCounterCallback =>
      mapGpuProbeCompileTimeEnabled && onCounterSnapshot != null;

  MapGpuResourceCounterSnapshot get snapshot =>
      mapGpuResourceCounterSnapshotFor(this);

  FlutterSceneSpritePreparedFrame<TTexture, TTopology, TInstance> prepareFrame({
    required MapFrameSnapshot frame,
    required List<MapPointSpriteInstanceBatch> batches,
  }) => prepareFlutterSceneSpriteFrame(
    owner: this,
    frame: frame,
    batches: batches,
  );

  void retireAll() => retireAllFlutterSceneSpriteResources(this);
}

FlutterSceneSpritePreparedFrame<TTexture, TTopology, TInstance>
prepareFlutterSceneSpriteFrame<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required MapFrameSnapshot frame,
  required List<MapPointSpriteInstanceBatch> batches,
}) {
  if (owner._candidate != null) {
    throw const FlutterSceneSpriteResourceFailure(
      reason: FlutterSceneSpriteResourceFailureReason.candidateState,
      message: 'The previous candidate must be committed or rolled back.',
    );
  }
  _validateSpriteFrame(owner: owner, frame: frame, batches: batches);
  final pins = _MapSpriteFramePins<TTexture, TTopology, TInstance>(
    frame: frame,
  );
  var failureReason = FlutterSceneSpriteResourceFailureReason.shaderInterface;
  try {
    if (mapGpuProbeCompileTimeEnabled) {
      owner.probeRuntime?.throwIfRequested(MapGpuFaultPoint.shaderInterface);
    }
    batches.forEach(owner.backend.preflightShaderInterface);
    final atlases = <String, MapSpriteAtlas>{
      for (final batch in batches) batch.atlas.identity.value: batch.atlas,
    };
    failureReason = FlutterSceneSpriteResourceFailureReason.atlasUpload;
    for (final atlas in atlases.values) {
      pins.textures.add(_pinTexture(owner: owner, frame: frame, atlas: atlas));
    }
    if (batches.isNotEmpty) {
      failureReason = FlutterSceneSpriteResourceFailureReason.topologyPrepare;
      pins.topologies.add(_pinTopology(owner: owner, frame: frame));
    }
    final topology = pins.topologies.firstOrNull?.resource;
    if (topology != null) {
      failureReason = FlutterSceneSpriteResourceFailureReason.instancePrepare;
      for (final batch in batches) {
        pins.instances.add(
          _pinInstance(
            owner: owner,
            frame: frame,
            topology: topology,
            batch: batch,
          ),
        );
      }
    }
  } on FlutterSceneSpriteResourceFailure {
    _releaseSpriteFrame(owner: owner, pins: pins);
    rethrow;
  } on Exception catch (error, stackTrace) {
    _releaseSpriteFrame(owner: owner, pins: pins);
    throw FlutterSceneSpriteResourceFailure(
      reason: failureReason,
      message: error.toString(),
      stackTrace: stackTrace,
    );
    // Candidate rollback must also cover synchronous GPU StateError failures.
    // ignore: avoid_catching_errors
  } on Error catch (error, stackTrace) {
    _releaseSpriteFrame(owner: owner, pins: pins);
    throw FlutterSceneSpriteResourceFailure(
      reason: failureReason,
      message: error.toString(),
      stackTrace: stackTrace,
    );
  }
  final textureByKey = {for (final entry in pins.textures) entry.key: entry};
  final instanceByKey = {for (final entry in pins.instances) entry.key: entry};
  final topology = pins.topologies.firstOrNull;
  final nodes =
      <FlutterSceneSpritePreparedNode<TTexture, TTopology, TInstance>>[];
  for (final batch in batches) {
    final texture =
        textureByKey[(frame.contextGeneration, batch.atlas.identity.value)];
    final instance =
        instanceByKey[(frame.contextGeneration, batch.instanceGeneration)];
    if (texture == null || topology == null || instance == null) {
      _releaseSpriteFrame(owner: owner, pins: pins);
      throw const FlutterSceneSpriteResourceFailure(
        reason: FlutterSceneSpriteResourceFailureReason.candidateState,
        message: 'Prepared sprite resources are incomplete.',
      );
    }
    nodes.add(
      FlutterSceneSpritePreparedNode(
        batch: batch,
        texture: texture.resource,
        topology: topology.resource,
        instance: instance.resource,
      ),
    );
  }
  pins._nodeCount = nodes.length;
  owner._candidate = pins;
  if (mapGpuProbeCompileTimeEnabled) {
    final counters = _debugCountersFor(owner);
    counters
      .._nodeCreates += nodes.length
      .._contextGeneration = frame.contextGeneration;
    _notifySpriteCounters(owner);
  }
  return FlutterSceneSpritePreparedFrame._(
    owner,
    pins,
    List.unmodifiable(nodes),
  );
}

void commitFlutterSceneSpritePreparedFrame<TTexture, TTopology, TInstance>(
  FlutterSceneSpritePreparedFrame<TTexture, TTopology, TInstance> prepared,
) {
  if (prepared._isFinalized) {
    return;
  }
  final owner = prepared.owner;
  if (!identical(owner._candidate, prepared._pins)) {
    throw const FlutterSceneSpriteResourceFailure(
      reason: FlutterSceneSpriteResourceFailureReason.candidateState,
      message: 'Sprite candidate is no longer current.',
    );
  }
  final previous = owner._active;
  owner
    .._candidate = null
    .._active = prepared._pins;
  prepared._isFinalized = true;
  if (previous != null) {
    _moveSpriteFrameToPending(owner: owner, pins: previous);
  }
  if (mapGpuProbeCompileTimeEnabled) {
    _notifySpriteCounters(owner);
  }
}

void rollbackFlutterSceneSpritePreparedFrame<TTexture, TTopology, TInstance>(
  FlutterSceneSpritePreparedFrame<TTexture, TTopology, TInstance> prepared,
) {
  if (prepared._isFinalized) {
    return;
  }
  final owner = prepared.owner;
  if (identical(owner._candidate, prepared._pins)) {
    owner._candidate = null;
  }
  prepared._isFinalized = true;
  _releaseSpriteFrame(owner: owner, pins: prepared._pins);
  if (mapGpuProbeCompileTimeEnabled) {
    _notifySpriteCounters(owner);
  }
}

void retireAllFlutterSceneSpriteResources<TTexture, TTopology, TInstance>(
  FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance> owner,
) {
  final candidate = owner._candidate;
  if (candidate != null) {
    owner._candidate = null;
    _releaseSpriteFrame(owner: owner, pins: candidate);
  }
  final active = owner._active;
  if (active != null) {
    owner._active = null;
    _moveSpriteFrameToPending(owner: owner, pins: active);
  }
  if (mapGpuProbeCompileTimeEnabled) {
    _notifySpriteCounters(owner);
  }
}

MapGpuResourceCounterSnapshot mapGpuResourceCounterSnapshotFor<
  TTexture,
  TTopology,
  TInstance
>(FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance> owner) {
  final active = owner._active;
  final candidate = owner._candidate;
  final counters = owner._debugCounters;
  return MapGpuResourceCounterSnapshot(
    texture: MapGpuResourceKindCounter(
      active: active?.textures.length ?? 0,
      candidate: candidate?.textures.length ?? 0,
      pendingRetire: owner._pending.fold(
        0,
        (total, pending) => total + pending.pins.textures.length,
      ),
      uploads: counters?._textureUploads ?? 0,
      retires: counters?._textureRetires ?? 0,
    ),
    topology: MapGpuResourceKindCounter(
      active: active?.topologies.length ?? 0,
      candidate: candidate?.topologies.length ?? 0,
      pendingRetire: owner._pending.fold(
        0,
        (total, pending) => total + pending.pins.topologies.length,
      ),
      uploads: counters?._topologyUploads ?? 0,
      retires: counters?._topologyRetires ?? 0,
    ),
    instance: MapGpuResourceKindCounter(
      active: active?.instances.length ?? 0,
      candidate: candidate?.instances.length ?? 0,
      pendingRetire: owner._pending.fold(
        0,
        (total, pending) => total + pending.pins.instances.length,
      ),
      uploads: counters?._instanceUploads ?? 0,
      retires: counters?._instanceRetires ?? 0,
    ),
    node: MapGpuResourceKindCounter(
      active: active?._nodeCount ?? 0,
      candidate: candidate?._nodeCount ?? 0,
      pendingRetire: owner._pending.fold(
        0,
        (total, pending) => total + pending.pins._nodeCount,
      ),
      uploads: counters?._nodeCreates ?? 0,
      retires: counters?._nodeRetires ?? 0,
    ),
    rendererContextGeneration: counters?._contextGeneration ?? 0,
  );
}

void _validateSpriteFrame<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required MapFrameSnapshot frame,
  required List<MapPointSpriteInstanceBatch> batches,
}) {
  if (batches.any((batch) => !identical(batch.frame, frame))) {
    throw const FlutterSceneSpriteResourceFailure(
      reason: FlutterSceneSpriteResourceFailureReason.frameMismatch,
      message: 'Every sprite batch must use the candidate frame.',
    );
  }
  final atlasCount = batches
      .map((batch) => batch.atlas.identity.value)
      .toSet()
      .length;
  if (atlasCount > owner.limits.maxActiveAtlases) {
    throw const FlutterSceneSpriteResourceFailure(
      reason: FlutterSceneSpriteResourceFailureReason.atlasLimitExceeded,
      message: 'Candidate exceeds maxActiveAtlases.',
    );
  }
  final topologyCount = batches.isEmpty ? 0 : 1;
  if (topologyCount > owner.limits.maxTopologyVariants) {
    throw const FlutterSceneSpriteResourceFailure(
      reason: FlutterSceneSpriteResourceFailureReason.topologyLimitExceeded,
      message: 'Candidate exceeds maxTopologyVariants.',
    );
  }
  if (batches.length > owner.limits.maxPolicyBatches) {
    throw const FlutterSceneSpriteResourceFailure(
      reason: FlutterSceneSpriteResourceFailureReason.policyLimitExceeded,
      message: 'Candidate exceeds maxPolicyBatches.',
    );
  }
  final active = owner._active;
  final candidate = owner._candidate;
  final textureLive =
      (active?.textures.length ?? 0) +
      (candidate?.textures.length ?? 0) +
      owner._pending.fold(
        0,
        (total, pending) => total + pending.pins.textures.length,
      );
  final topologyLive =
      (active?.topologies.length ?? 0) +
      (candidate?.topologies.length ?? 0) +
      owner._pending.fold(
        0,
        (total, pending) => total + pending.pins.topologies.length,
      );
  final instanceLive =
      (active?.instances.length ?? 0) +
      (candidate?.instances.length ?? 0) +
      owner._pending.fold(
        0,
        (total, pending) => total + pending.pins.instances.length,
      );
  final nodeLive =
      (active?._nodeCount ?? 0) +
      (candidate?._nodeCount ?? 0) +
      owner._pending.fold(
        0,
        (total, pending) => total + pending.pins._nodeCount,
      );
  final frameMultiplier = owner.maxFramesInFlight + 1;
  final exceedsLivePins =
      textureLive + atlasCount >
          owner.limits.maxActiveAtlases * frameMultiplier ||
      topologyLive + topologyCount >
          owner.limits.maxTopologyVariants * frameMultiplier ||
      instanceLive + batches.length >
          owner.limits.maxPolicyBatches * frameMultiplier ||
      nodeLive + batches.length >
          owner.limits.maxPolicyBatches * frameMultiplier;
  if (exceedsLivePins) {
    throw const FlutterSceneSpriteResourceFailure(
      reason: FlutterSceneSpriteResourceFailureReason.livePinLimitExceeded,
      message: 'Candidate would exceed the frames-in-flight pin bound.',
    );
  }
}

_MapSpriteResourceEntry<_MapSpriteTextureKey, TTexture>
_pinTexture<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required MapFrameSnapshot frame,
  required MapSpriteAtlas atlas,
}) {
  final key = (frame.contextGeneration, atlas.identity.value);
  var entry = owner._textures[key];
  if (entry == null) {
    if (mapGpuProbeCompileTimeEnabled) {
      owner.probeRuntime?.throwIfRequested(MapGpuFaultPoint.atlasUpload);
    }
    entry = _MapSpriteResourceEntry(
      key: key,
      resource: owner.backend.uploadTexture(atlas),
    );
    owner._textures[key] = entry;
    if (mapGpuProbeCompileTimeEnabled) {
      _debugCountersFor(owner)._textureUploads++;
    }
  }
  entry._pinCount++;
  return entry;
}

_MapSpriteResourceEntry<_MapSpriteTopologyKey, TTopology>
_pinTopology<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required MapFrameSnapshot frame,
}) {
  final key = (
    frame.contextGeneration,
    mapSpriteInstanceAbiVersion,
    mapSpriteMaterialAbiVersion,
  );
  var entry = owner._topologies[key];
  if (entry == null) {
    entry = _MapSpriteResourceEntry(
      key: key,
      resource: owner.backend.prepareTopology(
        spriteAbiVersion: mapSpriteInstanceAbiVersion,
        materialVersion: mapSpriteMaterialAbiVersion,
      ),
    );
    owner._topologies[key] = entry;
    if (mapGpuProbeCompileTimeEnabled) {
      _debugCountersFor(owner)._topologyUploads++;
    }
  }
  entry._pinCount++;
  return entry;
}

_MapSpriteResourceEntry<_MapSpriteInstanceKey, TInstance>
_pinInstance<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required MapFrameSnapshot frame,
  required TTopology topology,
  required MapPointSpriteInstanceBatch batch,
}) {
  final key = (frame.contextGeneration, batch.instanceGeneration);
  var entry = owner._instances[key];
  if (entry == null) {
    entry = _MapSpriteResourceEntry(
      key: key,
      resource: owner.backend.prepareInstance(
        topology: topology,
        batch: batch,
      ),
    );
    owner._instances[key] = entry;
    if (mapGpuProbeCompileTimeEnabled) {
      _debugCountersFor(owner)._instanceUploads++;
    }
  }
  entry._pinCount++;
  return entry;
}

void _moveSpriteFrameToPending<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required _MapSpriteFramePins<TTexture, TTopology, TInstance> pins,
}) {
  final pending = _MapSpritePendingFrame(pins: pins);
  owner._pending.add(pending);
  late final Future<void> completion;
  try {
    completion = owner.waitForGpuCompletion();
  } on Exception {
    _completePendingSpriteFrame(owner: owner, pending: pending);
    return;
    // A synchronous GPU completion barrier may report context loss as Error.
    // ignore: avoid_catching_errors
  } on Error {
    _completePendingSpriteFrame(owner: owner, pending: pending);
    return;
  }
  unawaited(
    _retireSpriteFrameAfter(
      owner: owner,
      pending: pending,
      completion: completion,
    ),
  );
}

Future<void> _retireSpriteFrameAfter<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required _MapSpritePendingFrame<TTexture, TTopology, TInstance> pending,
  required Future<void> completion,
}) async {
  try {
    await completion;
    // GPU integrations may complete with non-Exception context-loss objects.
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    // Context loss still releases app-owned references exactly once.
  }
  _completePendingSpriteFrame(owner: owner, pending: pending);
}

void _completePendingSpriteFrame<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required _MapSpritePendingFrame<TTexture, TTopology, TInstance> pending,
}) {
  if (pending._didRelease) {
    return;
  }
  pending._didRelease = true;
  owner._pending.remove(pending);
  _releaseSpriteFrame(owner: owner, pins: pending.pins);
  if (mapGpuProbeCompileTimeEnabled) {
    _notifySpriteCounters(owner);
  }
}

void _releaseSpriteFrame<TTexture, TTopology, TInstance>({
  required FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance>
  owner,
  required _MapSpriteFramePins<TTexture, TTopology, TInstance> pins,
}) {
  if (pins._didRelease) {
    return;
  }
  pins._didRelease = true;
  if (mapGpuProbeCompileTimeEnabled) {
    _debugCountersFor(owner)._nodeRetires += pins._nodeCount;
  }
  for (final entry in pins.instances) {
    entry._pinCount--;
    if (entry._pinCount == 0) {
      owner._instances.remove(entry.key);
      _retireSpriteResource(
        label: 'instance',
        retire: () => owner.backend.retireInstance(entry.resource),
      );
      if (mapGpuProbeCompileTimeEnabled) {
        _debugCountersFor(owner)._instanceRetires++;
      }
    }
  }
  for (final entry in pins.topologies) {
    entry._pinCount--;
    if (entry._pinCount == 0) {
      owner._topologies.remove(entry.key);
      _retireSpriteResource(
        label: 'topology',
        retire: () => owner.backend.retireTopology(entry.resource),
      );
      if (mapGpuProbeCompileTimeEnabled) {
        _debugCountersFor(owner)._topologyRetires++;
      }
    }
  }
  for (final entry in pins.textures) {
    entry._pinCount--;
    if (entry._pinCount == 0) {
      owner._textures.remove(entry.key);
      _retireSpriteResource(
        label: 'texture',
        retire: () => owner.backend.retireTexture(entry.resource),
      );
      if (mapGpuProbeCompileTimeEnabled) {
        _debugCountersFor(owner)._textureRetires++;
      }
    }
  }
}

void _retireSpriteResource({
  required String label,
  required VoidCallback retire,
}) {
  try {
    retire();
  } on Exception catch (error, stackTrace) {
    debugPrint('Sprite $label retirement failed: $error\n$stackTrace');
    // A GPU wrapper can report use-after-retire as StateError.
    // ignore: avoid_catching_errors
  } on Error catch (error, stackTrace) {
    debugPrint('Sprite $label retirement failed: $error\n$stackTrace');
  }
}

void _notifySpriteCounters<TTexture, TTopology, TInstance>(
  FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance> owner,
) {
  final callback = owner.onCounterSnapshot;
  if (callback != null) {
    callback(owner.snapshot);
  }
}

_MapGpuDebugResourceCounters _debugCountersFor<TTexture, TTopology, TInstance>(
  FlutterSceneSpriteResourceOwner<TTexture, TTopology, TInstance> owner,
) {
  final counters = owner._debugCounters;
  if (counters == null) {
    throw StateError('GPU probe counters are disabled at compile time.');
  }
  return counters;
}

final class _MapGpuDebugResourceCounters {
  var _textureUploads = 0;
  var _topologyUploads = 0;
  var _instanceUploads = 0;
  var _nodeCreates = 0;
  var _textureRetires = 0;
  var _topologyRetires = 0;
  var _instanceRetires = 0;
  var _nodeRetires = 0;
  var _contextGeneration = 0;
}

final class _MapSpriteResourceEntry<TKey, TResource> {
  _MapSpriteResourceEntry({required this.key, required this.resource});

  final TKey key;
  final TResource resource;
  var _pinCount = 0;
}

final class _MapSpriteFramePins<TTexture, TTopology, TInstance> {
  _MapSpriteFramePins({required this.frame});

  final MapFrameSnapshot frame;
  final textures = <_MapSpriteResourceEntry<_MapSpriteTextureKey, TTexture>>[];
  final topologies =
      <_MapSpriteResourceEntry<_MapSpriteTopologyKey, TTopology>>[];
  final instances =
      <_MapSpriteResourceEntry<_MapSpriteInstanceKey, TInstance>>[];
  var _nodeCount = 0;
  var _didRelease = false;
}

final class _MapSpritePendingFrame<TTexture, TTopology, TInstance> {
  _MapSpritePendingFrame({required this.pins});

  final _MapSpriteFramePins<TTexture, TTopology, TInstance> pins;
  var _didRelease = false;
}
