import 'dart:io';

final class DartApiCompiler {
  const new({
    required this.dartExecutable,
    required this.packageConfig,
  });

  static DartApiCompiler resolve() {
    var workspace = Directory.current;
    while (!File(
      '${workspace.path}/.dart_tool/package_config.json',
    ).existsSync()) {
      final parent = workspace.parent;
      if (parent.path == workspace.path) {
        throw StateError('Could not locate workspace package_config.json');
      }
      workspace = parent;
    }

    var flutterSdkDirectory = File(Platform.resolvedExecutable).parent;
    while (!File(
      '${flutterSdkDirectory.path}/dart-sdk/bin/dart',
    ).existsSync()) {
      final parent = flutterSdkDirectory.parent;
      if (parent.path == flutterSdkDirectory.path) {
        throw StateError(
          'Could not locate Dart SDK from Platform.resolvedExecutable',
        );
      }
      flutterSdkDirectory = parent;
    }

    return DartApiCompiler(
      dartExecutable: '${flutterSdkDirectory.path}/dart-sdk/bin/dart',
      packageConfig: '${workspace.path}/.dart_tool/package_config.json',
    );
  }

  final String dartExecutable;
  final String packageConfig;

  Future<ProcessResult> compile({
    required Directory directory,
    required String name,
    required String source,
  }) async {
    final sourceFile = File('${directory.path}/$name.dart');
    await sourceFile.writeAsString(source);
    return Process.run(dartExecutable, [
      'compile',
      'kernel',
      '--packages=$packageConfig',
      '--output=${directory.path}/$name.dill',
      sourceFile.path,
    ]);
  }
}
