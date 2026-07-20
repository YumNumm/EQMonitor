import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'fake_style_controller.dart';

void main() {
  setUpAll(() {
    try {
      talker_lib.talker = Talker();
      // ignore: avoid_catching_errors
    } on Error catch (_) {}
  });

  test('先頭 layer の削除失敗後も残りの resource を削除する', () async {
    final style = FakeStyleController(failingLayerIds: {'first'});

    await removeMapStyleResources(
      styleController: style,
      layerIds: const ['first', 'second'],
      sourceIds: const ['source'],
      imageIds: const ['image'],
    );

    expect(style.removedLayerIds, ['first', 'second']);
    expect(style.removedSourceIds, ['source']);
    expect(style.removedImageIds, ['image']);
  });

  test('source の削除失敗後も残りの source と image を削除する', () async {
    final style = FakeStyleController(failingSourceIds: {'first-source'});

    await removeMapStyleResources(
      styleController: style,
      sourceIds: const ['first-source', 'second-source'],
      imageIds: const ['image'],
    );

    expect(style.removedSourceIds, ['first-source', 'second-source']);
    expect(style.removedImageIds, ['image']);
  });

  test('複数 layer/source の途中失敗でも全 resource を順に試行する', () async {
    final style = FakeStyleController(
      failingLayerIds: {'second-layer'},
      failingSourceIds: {'first-source'},
    );

    await removeMapStyleResources(
      styleController: style,
      layerIds: const ['first-layer', 'second-layer', 'third-layer'],
      sourceIds: const ['first-source', 'second-source'],
      imageIds: const ['first-image', 'second-image'],
    );

    expect(style.removedLayerIds, [
      'first-layer',
      'second-layer',
      'third-layer',
    ]);
    expect(style.removedSourceIds, ['first-source', 'second-source']);
    expect(style.removedImageIds, ['first-image', 'second-image']);
  });
}
