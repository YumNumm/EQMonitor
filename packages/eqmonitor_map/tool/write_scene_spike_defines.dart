import 'dart:convert';
import 'dart:io';

const flutterSceneRevision = '695c954f237fabef65d49fa7199002851d2dcd88';
const flutterEngineContentHashEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_FLUTTER_ENGINE_CONTENT_HASH';
const dartVersionEnvironmentKey = 'EQMONITOR_SCENE_SPIKE_DART_VERSION';
const dartSourceRevisionEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_DART_SOURCE_REVISION';
const dartSourceRevision = 'd402ff7c9c8442d64aa8148609480aa0e04a24fd';

Future<void> main() async {
  final repositoryRoot = await resolveRepositoryRoot(
    scriptUri: Platform.script,
  );
  final flutterMachineJson = await runTextProcess(
    executable: 'mise',
    arguments: const ['exec', '--', 'flutter', '--version', '--machine'],
  );
  final flutterMetadata = decodeFlutterMetadata(flutterMachineJson);
  final rendererMetadata = await readRendererCheckoutMetadata(
    repositoryRoot: repositoryRoot,
  );
  final packageRoot = File.fromUri(Platform.script).parent.parent;
  final outputDirectory = Directory(
    '${packageRoot.path}/example/.dart_tool',
  );
  await outputDirectory.create(recursive: true);
  final outputFile = File(
    '${outputDirectory.path}/scene_spike_defines.json',
  );
  await outputFile.writeAsString(
    const JsonEncoder.withIndent('  ').convert(
      buildSceneSpikeDefines(
        flutterMetadata: flutterMetadata,
        rendererMetadata: rendererMetadata,
      ),
    ),
  );
}

Future<Directory> resolveRepositoryRoot({required Uri scriptUri}) async {
  final packageRoot = File.fromUri(scriptUri).parent.parent.absolute;
  final packageName = packageRoot.uri.pathSegments
      .where((segment) => segment.isNotEmpty)
      .last;
  final packagesDirectory = packageRoot.parent;
  final packagesName = packagesDirectory.uri.pathSegments
      .where((segment) => segment.isNotEmpty)
      .last;
  if (packageName != 'eqmonitor_map' || packagesName != 'packages') {
    throw StateError(
      'Scene spike writer must run from packages/eqmonitor_map/tool.',
    );
  }
  final candidate = packagesDirectory.parent;
  final gitRootPath = await runTextProcess(
    executable: 'git',
    arguments: const ['rev-parse', '--show-toplevel'],
    workingDirectory: candidate.path,
  );
  final gitRoot = Directory(gitRootPath);
  if (candidate.resolveSymbolicLinksSync() !=
      gitRoot.resolveSymbolicLinksSync()) {
    throw StateError('Platform.script repository root does not match Git.');
  }
  return gitRoot;
}

class RendererCheckoutMetadata {
  const RendererCheckoutMetadata({
    required this.revision,
    required this.isDirty,
  });

  final String revision;
  final bool isDirty;
}

Future<RendererCheckoutMetadata> readRendererCheckoutMetadata({
  required Directory repositoryRoot,
}) async {
  final revision = await runTextProcess(
    executable: 'git',
    arguments: const ['rev-parse', 'HEAD'],
    workingDirectory: repositoryRoot.path,
  );
  final status = await runTextProcess(
    executable: 'git',
    arguments: const [
      'status',
      '--porcelain=v1',
      '--untracked-files=all',
    ],
    workingDirectory: repositoryRoot.path,
  );
  return RendererCheckoutMetadata(
    revision: revision,
    isDirty: status.isNotEmpty,
  );
}

Map<String, dynamic> buildSceneSpikeDefines({
  required FlutterMachineMetadata flutterMetadata,
  required RendererCheckoutMetadata rendererMetadata,
}) => {
  'EQMONITOR_SCENE_SPIKE_FLUTTER_FRAMEWORK_REVISION':
      flutterMetadata.frameworkRevision,
  'EQMONITOR_SCENE_SPIKE_FLUTTER_ENGINE_REVISION':
      flutterMetadata.engineRevision,
  flutterEngineContentHashEnvironmentKey: flutterMetadata.engineContentHash,
  dartVersionEnvironmentKey: flutterMetadata.dartSdkVersion,
  dartSourceRevisionEnvironmentKey: dartSourceRevision,
  'EQMONITOR_SCENE_SPIKE_FLUTTER_SCENE_REVISION': flutterSceneRevision,
  'EQMONITOR_SCENE_SPIKE_RENDERER_REVISION': rendererMetadata.revision,
  'EQMONITOR_SCENE_SPIKE_RENDERER_CHECKOUT_DIRTY': rendererMetadata.isDirty,
};

class FlutterMachineMetadata {
  const FlutterMachineMetadata({
    required this.frameworkRevision,
    required this.engineRevision,
    required this.engineContentHash,
    required this.dartSdkVersion,
  });

  final String frameworkRevision;
  final String engineRevision;
  final String engineContentHash;
  final String dartSdkVersion;
}

FlutterMachineMetadata decodeFlutterMetadata(String source) {
  final decoded = jsonDecode(source);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Flutter machine output must be a JSON map.');
  }
  final frameworkRevision = decoded['frameworkRevision'];
  final engineRevision = decoded['engineRevision'];
  final engineContentHash = decoded['engineContentHash'];
  final dartSdkVersion = decoded['dartSdkVersion'];
  if (frameworkRevision is! String ||
      engineRevision is! String ||
      engineContentHash is! String ||
      engineContentHash.trim().isEmpty ||
      dartSdkVersion is! String) {
    throw const FormatException('Flutter machine revisions are missing.');
  }
  return FlutterMachineMetadata(
    frameworkRevision: frameworkRevision,
    engineRevision: engineRevision,
    engineContentHash: engineContentHash,
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
