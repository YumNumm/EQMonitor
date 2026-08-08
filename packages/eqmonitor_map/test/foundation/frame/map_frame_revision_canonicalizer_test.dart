import 'package:eqmonitor_map/src/foundation/frame/map_frame_revision.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sourceA = createMapSourceInstanceId(value: 'source-a');
  final sourceB = createMapSourceInstanceId(value: 'source-b');
  final digestA = createMapContentDigest(value: 'sha256:a');
  final digestB = createMapContentDigest(value: 'sha256:b');
  final ownerA = createMapNodeKey(value: 'owner-a');
  final ownerB = createMapNodeKey(value: 'owner-b');

  test('orders source and layer revisions by canonical identity', () {
    final sourceBStamp = createMapFrameSourceRevisionStamp(
      sourceInstanceId: sourceB,
      revision: 3,
      contentDigest: digestB,
    );
    final sourceAStamp = createMapFrameSourceRevisionStamp(
      sourceInstanceId: sourceA,
      revision: 2,
      contentDigest: digestA,
    );
    final sourceBOwnerB = createMapFrameLayerRevisionStamp(
      sourceInstanceId: sourceB,
      ownerKey: ownerB,
      revision: 7,
    );
    final sourceAOwnerB = createMapFrameLayerRevisionStamp(
      sourceInstanceId: sourceA,
      ownerKey: ownerB,
      revision: 6,
    );
    final sourceAOwnerA = createMapFrameLayerRevisionStamp(
      sourceInstanceId: sourceA,
      ownerKey: ownerA,
      revision: 5,
    );

    final revisions = canonicalizeMapFrameRevisions(
      revisions: [
        sourceBOwnerB,
        sourceAOwnerB,
        sourceBStamp,
        sourceAOwnerA,
        sourceAStamp,
      ],
    );

    expect(
      revisions,
      [sourceAStamp, sourceBStamp, sourceAOwnerA, sourceAOwnerB, sourceBOwnerB],
    );
  });

  test('rejects duplicate source or layer identities', () {
    final source = createMapFrameSourceRevisionStamp(
      sourceInstanceId: sourceA,
      revision: 1,
      contentDigest: digestA,
    );
    final newerSource = createMapFrameSourceRevisionStamp(
      sourceInstanceId: sourceA,
      revision: 2,
      contentDigest: digestB,
    );
    final layer = createMapFrameLayerRevisionStamp(
      sourceInstanceId: sourceA,
      ownerKey: ownerA,
      revision: 1,
    );
    final newerLayer = createMapFrameLayerRevisionStamp(
      sourceInstanceId: sourceA,
      ownerKey: ownerA,
      revision: 2,
    );

    expect(
      () => canonicalizeMapFrameRevisions(revisions: [source, newerSource]),
      throwsArgumentError,
    );
    expect(
      () => canonicalizeMapFrameRevisions(revisions: [layer, newerLayer]),
      throwsArgumentError,
    );
  });

  test('deep-owns the input list', () {
    final source = createMapFrameSourceRevisionStamp(
      sourceInstanceId: sourceA,
      revision: 1,
      contentDigest: digestA,
    );
    final layer = createMapFrameLayerRevisionStamp(
      sourceInstanceId: sourceA,
      ownerKey: ownerA,
      revision: 1,
    );
    final input = [layer, source];

    final canonical = canonicalizeMapFrameRevisions(revisions: input);
    input.clear();

    expect(canonical, [source, layer]);
    expect(() => canonical.add(source), throwsUnsupportedError);
  });
}
