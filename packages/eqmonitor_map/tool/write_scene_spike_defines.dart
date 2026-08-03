import 'dart:convert';
import 'dart:io';

const flutterFrameworkRevision = '4dacd3fc91d96262a33e5c598e17d816f0b35641';
const flutterEngineRevision = 'b1e405a9c311d858bef870c472bb24c015f4bcf9';
const flutterEngineContentHash = '73ac711b34da2a090d79ddb423918de40a7ffbf9';
const flutterSceneRevision = '695c954f237fabef65d49fa7199002851d2dcd88';
const flutterFrameworkRevisionEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_FLUTTER_FRAMEWORK_REVISION';
const flutterEngineRevisionEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_FLUTTER_ENGINE_REVISION';
const flutterEngineContentHashEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_FLUTTER_ENGINE_CONTENT_HASH';
const dartVersionEnvironmentKey = 'EQMONITOR_SCENE_SPIKE_DART_VERSION';
const dartSourceRevisionEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_DART_SOURCE_REVISION';
const flutterSceneRevisionEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_FLUTTER_SCENE_REVISION';
const rendererRevisionEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_RENDERER_REVISION';
const rendererCheckoutDirtyEnvironmentKey =
    'EQMONITOR_SCENE_SPIKE_RENDERER_CHECKOUT_DIRTY';
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
  final defines = buildSceneSpikeDefines(
    flutterMetadata: flutterMetadata,
    rendererMetadata: rendererMetadata,
  );
  SceneSpikeDefineValidator.validate(
    defines: defines,
    expectedRendererRevision: rendererMetadata.revision,
  );
  await outputFile.writeAsString(
    const JsonEncoder.withIndent('  ').convert(defines),
  );
  final persisted = jsonDecode(await outputFile.readAsString());
  if (persisted is! Map<String, dynamic>) {
    throw const FormatException('Scene spike defines must be a JSON map.');
  }
  SceneSpikeDefineValidator.validate(
    defines: persisted,
    expectedRendererRevision: rendererMetadata.revision,
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
  flutterFrameworkRevisionEnvironmentKey: flutterMetadata.frameworkRevision,
  flutterEngineRevisionEnvironmentKey: flutterMetadata.engineRevision,
  flutterEngineContentHashEnvironmentKey: flutterMetadata.engineContentHash,
  dartVersionEnvironmentKey: flutterMetadata.dartSdkVersion,
  dartSourceRevisionEnvironmentKey: dartSourceRevision,
  flutterSceneRevisionEnvironmentKey: flutterSceneRevision,
  rendererRevisionEnvironmentKey: rendererMetadata.revision,
  rendererCheckoutDirtyEnvironmentKey: rendererMetadata.isDirty,
};

class SceneSpikeDefineValidator {
  const SceneSpikeDefineValidator._();

  static void validate({
    required Map<String, dynamic> defines,
    required String expectedRendererRevision,
  }) {
    final expectedRevisions = {
      flutterFrameworkRevisionEnvironmentKey: flutterFrameworkRevision,
      flutterEngineRevisionEnvironmentKey: flutterEngineRevision,
      flutterEngineContentHashEnvironmentKey: flutterEngineContentHash,
      dartSourceRevisionEnvironmentKey: dartSourceRevision,
      flutterSceneRevisionEnvironmentKey: flutterSceneRevision,
      rendererRevisionEnvironmentKey: expectedRendererRevision,
    };
    for (final revision in expectedRevisions.entries) {
      final actual = defines[revision.key];
      if (actual is! String ||
          !RegExp(r'^[0-9a-f]{40}$').hasMatch(actual) ||
          actual != revision.value) {
        throw FormatException('${revision.key} is missing or invalid.');
      }
    }
    final dartVersion = defines[dartVersionEnvironmentKey];
    if (dartVersion is! String || dartVersion.trim().isEmpty) {
      throw const FormatException('Dart SDK version is missing or invalid.');
    }
    if (defines[rendererCheckoutDirtyEnvironmentKey] != false) {
      throw const FormatException('Renderer checkout must be clean.');
    }
  }
}

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
