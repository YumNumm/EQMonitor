import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('validates the version and owns immutable parameter bytes', () {
    final sourceBytes = Uint8List.fromList([1, 2, 3]);
    final block = createMapMaterialParameterBlock(
      version: 2,
      bytes: sourceBytes,
    );

    sourceBytes[0] = 9;

    expect(block.version, 2);
    expect(block.bytes, [1, 2, 3]);
    expect(() => block.bytes[0] = 9, throwsUnsupportedError);
    for (final version in [0, -1]) {
      expect(
        () => createMapMaterialParameterBlock(
          version: version,
          bytes: Uint8List(0),
        ),
        throwsArgumentError,
      );
    }
  });

  test('compares version and byte content independent of identity', () {
    final left = createMapMaterialParameterBlock(
      version: 2,
      bytes: Uint8List.fromList([1, 2, 3]),
    );
    final equalContent = createMapMaterialParameterBlock(
      version: 2,
      bytes: Uint8List.fromList([1, 2, 3]),
    );
    final differentBytes = createMapMaterialParameterBlock(
      version: 2,
      bytes: Uint8List.fromList([1, 2, 4]),
    );
    final differentLength = createMapMaterialParameterBlock(
      version: 2,
      bytes: Uint8List.fromList([1, 2]),
    );
    final differentVersion = createMapMaterialParameterBlock(
      version: 3,
      bytes: Uint8List.fromList([1, 2, 3]),
    );

    expect(identical(left.bytes, equalContent.bytes), isFalse);
    expect(haveEqualMapMaterialParameterContent(left, equalContent), isTrue);
    expect(haveEqualMapMaterialParameterContent(left, differentBytes), isFalse);
    expect(
      haveEqualMapMaterialParameterContent(left, differentLength),
      isFalse,
    );
    expect(
      haveEqualMapMaterialParameterContent(left, differentVersion),
      isFalse,
    );
  });
}
