import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/write_scene_spike_defines.dart';

void main() {
  group('scene spike define writer repository trust', () {
    test(
      'resolves the repository from the script and includes untracked files',
      () async {
        final repository = await Directory.systemTemp.createTemp(
          'scene-spike-metadata-',
        );
        addTearDown(() => repository.delete(recursive: true));
        final script = File(
          '${repository.path}/packages/eqmonitor_map/tool/'
          'write_scene_spike_defines.dart',
        );
        await script.create(recursive: true);
        await runGit(repository, const ['init']);
        await runGit(repository, const [
          'config',
          'user.email',
          'test@example.com',
        ]);
        await runGit(repository, const ['config', 'user.name', 'Test']);
        await runGit(repository, const ['add', '.']);
        await runGit(repository, const ['commit', '-m', 'initial']);

        final resolved = await resolveRepositoryRoot(scriptUri: script.uri);
        final clean = await readRendererCheckoutMetadata(
          repositoryRoot: resolved,
        );
        await File(
          '${repository.path}/untracked.txt',
        ).writeAsString('untracked');
        final dirty = await readRendererCheckoutMetadata(
          repositoryRoot: resolved,
        );

        expect(
          resolved.resolveSymbolicLinksSync(),
          repository.resolveSymbolicLinksSync(),
        );
        expect(clean.isDirty, isFalse);
        expect(dirty.isDirty, isTrue);
      },
    );

    test('writes the pinned Dart source revision into the define map', () {
      final defines = buildSceneSpikeDefines(
        flutterMetadata: const FlutterMachineMetadata(
          frameworkRevision: 'framework',
          engineRevision: 'engine',
          engineContentHash: 'engine artifact',
          dartSdkVersion: 'sdk version',
        ),
        rendererMetadata: const RendererCheckoutMetadata(
          revision: 'renderer',
          isDirty: false,
        ),
      );

      expect(
        defines[dartSourceRevisionEnvironmentKey],
        'd402ff7c9c8442d64aa8148609480aa0e04a24fd',
      );
      expect(
        defines[flutterEngineContentHashEnvironmentKey],
        'engine artifact',
      );
    });

    test('decodes a non-blank engine content hash from machine JSON', () {
      final metadata = decodeFlutterMetadata(
        jsonEncode({
          'frameworkRevision': 'framework',
          'engineRevision': 'engine',
          'engineContentHash': 'engine artifact',
          'dartSdkVersion': 'sdk version',
        }),
      );

      expect(metadata.engineContentHash, 'engine artifact');
    });

    test('rejects missing or blank engine content hash', () {
      final base = {
        'frameworkRevision': 'framework',
        'engineRevision': 'engine',
        'dartSdkVersion': 'sdk version',
      };

      expect(
        () => decodeFlutterMetadata(jsonEncode(base)),
        throwsFormatException,
      );
      expect(
        () => decodeFlutterMetadata(
          jsonEncode({...base, 'engineContentHash': ' '}),
        ),
        throwsFormatException,
      );
    });
  });
}

Future<void> runGit(Directory repository, List<String> arguments) async {
  final result = await Process.run(
    'git',
    arguments,
    workingDirectory: repository.path,
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      'git',
      arguments,
      '${result.stderr}',
      result.exitCode,
    );
  }
}
