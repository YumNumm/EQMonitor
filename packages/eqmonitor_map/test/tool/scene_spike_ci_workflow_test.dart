import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mobile CI builds consume the canonical clean manifest', () {
    const workflowPath =
        '.github/workflows/wc-check-eqmonitor-map-scene-spike.yaml';
    const writerScript =
        'packages/eqmonitor_map/tool/write_scene_spike_defines.dart';
    const writerCommand = 'dart run $writerScript';
    const manifestPath =
        'packages/eqmonitor_map/example/.dart_tool/'
        'scene_spike_defines.json';
    const buildArgument =
        '--dart-define-from-file=.dart_tool/scene_spike_defines.json';
    final source = SceneSpikeCiWorkflowFixture().read(workflowPath);
    final androidStart = source.indexOf('  android-build:');
    final iosStart = source.indexOf('  ios-build:');
    final androidJob = source.substring(androidStart, iosStart);
    final iosJob = source.substring(iosStart);

    expect(source, isNot(contains('EQMONITOR_MAP_SCENE_SPIKE_CI')));
    expect(source, isNot(contains('eqmonitor-map-scene-spike.json')));
    expect(writerCommand.allMatches(source), hasLength(2));
    expect('test -s $manifestPath'.allMatches(source), hasLength(2));
    expect(buildArgument.allMatches(source), hasLength(4));
    expect(
      androidJob,
      contains('flutter analyze --no-pub --fatal-infos packages/eqmonitor_map'),
    );
    expect(
      androidJob.indexOf('Analyze eqmonitor_map package'),
      lessThan(androidJob.indexOf(writerCommand)),
    );
    expect(
      androidJob.indexOf('Resolve example dependencies'),
      lessThan(androidJob.indexOf(writerCommand)),
    );
    expect(
      androidJob.indexOf(writerCommand),
      lessThan(androidJob.indexOf('Build Android profile')),
    );
    expect(
      iosJob.indexOf('Resolve example dependencies'),
      lessThan(iosJob.indexOf(writerCommand)),
    );
    expect(
      iosJob.indexOf(writerCommand),
      lessThan(iosJob.indexOf('Build iOS profile')),
    );
  });
}

class SceneSpikeCiWorkflowFixture {
  String read(String relativePath) {
    var directory = Directory.current.absolute;
    while (true) {
      final candidate = File('${directory.path}/$relativePath');
      if (candidate.existsSync()) {
        return candidate.readAsStringSync();
      }
      final parent = directory.parent;
      if (parent.path == directory.path) {
        throw StateError('Repository root could not be located.');
      }
      directory = parent;
    }
  }
}
