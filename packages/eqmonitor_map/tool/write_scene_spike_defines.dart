import 'dart:convert';
import 'dart:io';

const flutterSceneRevision = '695c954f237fabef65d49fa7199002851d2dcd88';
const dartVersionEnvironmentKey = 'EQMONITOR_SCENE_SPIKE_DART_VERSION';

Future<void> main() async {
  final repositoryRoot = await runTextProcess(
    executable: 'git',
    arguments: const ['rev-parse', '--show-toplevel'],
  );
  final flutterMachineJson = await runTextProcess(
    executable: 'mise',
    arguments: const ['exec', '--', 'flutter', '--version', '--machine'],
  );
  final flutterMetadata = decodeFlutterMetadata(flutterMachineJson);
  final rendererRevision = await runTextProcess(
    executable: 'git',
    arguments: const ['rev-parse', 'HEAD'],
    workingDirectory: repositoryRoot,
  );
  final dirtyResult = await Process.run(
    'git',
    const ['diff', '--quiet', 'HEAD', '--'],
    workingDirectory: repositoryRoot,
  );
  if (dirtyResult.exitCode != 0 && dirtyResult.exitCode != 1) {
    throw ProcessException(
      'git',
      const ['diff', '--quiet', 'HEAD', '--'],
      '${dirtyResult.stderr}',
      dirtyResult.exitCode,
    );
  }
  final packageRoot = File.fromUri(Platform.script).parent.parent;
  final outputDirectory = Directory(
    '${packageRoot.path}/example/.dart_tool',
  );
  await outputDirectory.create(recursive: true);
  final outputFile = File(
    '${outputDirectory.path}/scene_spike_defines.json',
  );
  await outputFile.writeAsString(
    const JsonEncoder.withIndent('  ').convert({
      'EQMONITOR_SCENE_SPIKE_FLUTTER_FRAMEWORK_REVISION':
          flutterMetadata.frameworkRevision,
      'EQMONITOR_SCENE_SPIKE_FLUTTER_ENGINE_REVISION':
          flutterMetadata.engineRevision,
      dartVersionEnvironmentKey: flutterMetadata.dartSdkVersion,
      'EQMONITOR_SCENE_SPIKE_FLUTTER_SCENE_REVISION': flutterSceneRevision,
      'EQMONITOR_SCENE_SPIKE_RENDERER_REVISION': rendererRevision,
      'EQMONITOR_SCENE_SPIKE_RENDERER_CHECKOUT_DIRTY':
          dirtyResult.exitCode == 1,
    }),
  );
}

class FlutterMachineMetadata {
  const FlutterMachineMetadata({
    required this.frameworkRevision,
    required this.engineRevision,
    required this.dartSdkVersion,
  });

  final String frameworkRevision;
  final String engineRevision;
  final String dartSdkVersion;
}

FlutterMachineMetadata decodeFlutterMetadata(String source) {
  final decoded = jsonDecode(source);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Flutter machine output must be a JSON map.');
  }
  final frameworkRevision = decoded['frameworkRevision'];
  final engineRevision = decoded['engineRevision'];
  final dartSdkVersion = decoded['dartSdkVersion'];
  if (frameworkRevision is! String ||
      engineRevision is! String ||
      dartSdkVersion is! String) {
    throw const FormatException('Flutter machine revisions are missing.');
  }
  return FlutterMachineMetadata(
    frameworkRevision: frameworkRevision,
    engineRevision: engineRevision,
    dartSdkVersion: dartSdkVersion,
  );
}

Future<String> runTextProcess({
  required String executable,
  required List<String> arguments,
  String? workingDirectory,
}) async {
  final result = await Process.run(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    environment: {
      ...Platform.environment,
      'MISE_EXEC_AUTO_INSTALL': '0',
    },
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      executable,
      arguments,
      '${result.stderr}',
      result.exitCode,
    );
  }
  return '${result.stdout}'.trim();
}
