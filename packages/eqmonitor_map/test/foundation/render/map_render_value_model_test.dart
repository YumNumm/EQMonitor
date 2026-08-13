import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('validates pipeline keys and gives equal values equal identity', () {
    final key = createMapRenderPipelineKey(version: 2, key: '  fill  ');
    final sameKey = createMapRenderPipelineKey(version: 2, key: 'fill');

    expect((key.version, key.key), (2, 'fill'));
    expect(key, sameKey);
    expect(key.hashCode, sameKey.hashCode);
    expect(key, isNot(createMapRenderPipelineKey(version: 3, key: 'fill')));
    expect(key, isNot(createMapRenderPipelineKey(version: 2, key: 'line')));

    for (final createInvalid in [
      () => createMapRenderPipelineKey(version: 0, key: 'fill'),
      () => createMapRenderPipelineKey(version: -1, key: 'fill'),
      () => createMapRenderPipelineKey(version: 1, key: ' \n\t '),
    ]) {
      expect(createInvalid, throwsArgumentError);
    }
  });

  test('validates batch keys and retains phase-policy identity fields', () {
    final key = createMapRenderBatchKey(
      version: 3,
      nodeKey: createMapNodeKey(value: 'base-map'),
      scopeKey: '  tile/14/14556/6451  ',
      materialKey: '  coastline  ',
      phasePolicyVersion: 4,
      phase: 2,
    );
    final sameKey = createMapRenderBatchKey(
      version: 3,
      nodeKey: createMapNodeKey(value: 'base-map'),
      scopeKey: 'tile/14/14556/6451',
      materialKey: 'coastline',
      phasePolicyVersion: 4,
      phase: 2,
    );

    expect(
      (
        key.version,
        key.nodeKey.value,
        key.scopeKey,
        key.materialKey,
        key.phasePolicyVersion,
        key.phase,
      ),
      (3, 'base-map', 'tile/14/14556/6451', 'coastline', 4, 2),
    );
    expect(key, sameKey);
    expect(key.hashCode, sameKey.hashCode);
    expect(
      key,
      isNot(
        createMapRenderBatchKey(
          version: 3,
          nodeKey: createMapNodeKey(value: 'base-map'),
          scopeKey: 'tile/14/14556/6451',
          materialKey: 'coastline',
          phasePolicyVersion: 4,
          phase: 3,
        ),
      ),
    );

    for (final invalid in [
      (version: 0, scope: 'tile', material: 'fill', policy: 1, phase: 0),
      (version: -1, scope: 'tile', material: 'fill', policy: 1, phase: 0),
      (version: 1, scope: ' ', material: 'fill', policy: 1, phase: 0),
      (version: 1, scope: 'tile', material: ' ', policy: 1, phase: 0),
      (version: 1, scope: 'tile', material: 'fill', policy: 0, phase: 0),
      (version: 1, scope: 'tile', material: 'fill', policy: -1, phase: 0),
      (version: 1, scope: 'tile', material: 'fill', policy: 1, phase: -1),
    ]) {
      expect(
        () => createMapRenderBatchKey(
          version: invalid.version,
          nodeKey: createMapNodeKey(value: 'base-map'),
          scopeKey: invalid.scope,
          materialKey: invalid.material,
          phasePolicyVersion: invalid.policy,
          phase: invalid.phase,
        ),
        throwsArgumentError,
      );
    }
  });

  test('exposes the material parameter block value shape', () {
    (int, Uint8List) readFields(MapMaterialParameterBlock block) =>
        (block.version, block.bytes);
    expect(readFields, isA<Function>());
  });
}
