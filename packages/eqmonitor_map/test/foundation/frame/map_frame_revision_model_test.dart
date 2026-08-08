import 'dart:io';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_revision.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final source = createMapSourceInstanceId(value: 'jma-tiles');
  final digest = createMapContentDigest(value: 'sha256:abc');
  final ownerKey = createMapNodeKey(value: 'prefecture-labels');

  group('MapFrameRevisionStamp', () {
    test('creates typed source and layer stamps with immutable values', () {
      final sourceStamp = createMapFrameSourceRevisionStamp(
        sourceInstanceId: source,
        revision: 14,
        contentDigest: digest,
      );
      final layerStamp = createMapFrameLayerRevisionStamp(
        sourceInstanceId: source,
        ownerKey: ownerKey,
        revision: 7,
      );

      expect(sourceStamp.scope, MapFrameRevisionScope.source);
      expect(sourceStamp.sourceInstanceId, source);
      expect(sourceStamp.revision, 14);
      expect(sourceStamp.contentDigest, digest);
      expect(sourceStamp.ownerKey, isNull);
      expect(layerStamp.scope, MapFrameRevisionScope.layer);
      expect(layerStamp.sourceInstanceId, source);
      expect(layerStamp.ownerKey, ownerKey);
      expect(layerStamp.revision, 7);
      expect(layerStamp.contentDigest, isNull);
      expect(
        sourceStamp,
        createMapFrameSourceRevisionStamp(
          sourceInstanceId: source,
          revision: 14,
          contentDigest: digest,
        ),
      );
    });

    test('rejects negative revisions before creating either stamp', () {
      expect(
        () => createMapFrameSourceRevisionStamp(
          sourceInstanceId: source,
          revision: -1,
          contentDigest: digest,
        ),
        throwsArgumentError,
      );
      expect(
        () => createMapFrameLayerRevisionStamp(
          sourceInstanceId: source,
          ownerKey: ownerKey,
          revision: -1,
        ),
        throwsArgumentError,
      );
    });

    test('does not generate an unchecked copyWith API', () {
      final generatedSource = File(
        'lib/src/foundation/frame/map_frame_revision.freezed.dart',
      ).readAsStringSync();

      expect(
        RegExp(r'\bcopyWith\b').hasMatch(generatedSource),
        isFalse,
      );
    });
  });
}
