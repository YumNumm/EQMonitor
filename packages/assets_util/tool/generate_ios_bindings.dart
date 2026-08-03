import 'dart:io';

import 'package:ffigen/ffigen.dart';

void main() {
  final packageRoot = Platform.script.resolve('../');
  final iosSdkResult = Process.runSync('xcrun', [
    '--sdk',
    'iphoneos',
    '--show-sdk-path',
  ]);
  final sdk = iosSdkResult.exitCode == 0
      ? iosSdkResult.stdout.toString().trim()
      : Process.runSync('xcrun', [
          '--sdk',
          'macosx',
          '--show-sdk-path',
        ]).stdout.toString().trim();
  final target = iosSdkResult.exitCode == 0
      ? 'arm64-apple-ios16.0'
      : 'arm64-apple-macosx15.6';
  Directory.fromUri(
    packageRoot.resolve('lib/src/ios'),
  ).createSync(recursive: true);
  final generator = FfiGenerator(
    output: Output(
      dartFile: packageRoot.resolve('lib/src/ios/eqm_assets_util.dart'),
      preamble: '''
// dart format off
// ignore_for_file: type=lint
''',
    ),
    headers: Headers(
      entryPoints: [packageRoot.resolve('build/lib/AssetsUtil.h')],
      compilerOptions: ['-isysroot', sdk, '-target', target],
    ),
    objectiveC: ObjectiveC(
      interfaces: Interfaces(
        includeMember: (declaration, member) => true,
        include: (declaration) =>
            declaration.originalName == 'EQMAssetsUtil' ||
            {'NSString', 'NSObject'}.contains(declaration.originalName),
      ),
      protocols: Protocols(
        include: (declaration) => declaration.originalName == 'EQMAssetsUtil',
        module: (declaration) => <String, String>{}[declaration.originalName],
        includeMember: (declaration, member) => true,
      ),
    ),
    enums: Enums(
      style: (declaration, suggestedStyle) => EnumStyle.intConstants,
    ),
  );
  generator.generate();
  final generatedBinding = File.fromUri(generator.output.dartFile);
  final normalizedBinding = generatedBinding
      .readAsLinesSync()
      .map((line) => line.trimRight())
      .join('\n');
  generatedBinding.writeAsStringSync('$normalizedBinding\n');
  stdout.writeln('Generated ${generator.output.dartFile.toFilePath()}');
}
