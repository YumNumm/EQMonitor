import 'dart:io';

import 'package:ffigen/ffigen.dart';

Future<void> main() async {
  final packageRoot = Platform.script.resolve('../');
  final sdk = await Process.run('xcrun', [
    '--sdk',
    'iphoneos',
    '--show-sdk-path',
  ]);
  final sdkPath = (sdk.stdout as String).trim();
  const globals = {
    'NSURLVolumeTotalCapacityKey',
    'NSURLVolumeAvailableCapacityKey',
    'NSURLVolumeAvailableCapacityForImportantUsageKey',
    'NSURLVolumeAvailableCapacityForOpportunisticUsageKey',
  };
  FfiGenerator(
    output: Output(
      dart: DartOutput(
        path: packageRoot.resolve(
          'lib/src/device_storage/ios/ios_bindings.g.dart',
        ),
      ),
      preamble: '''
// dart format off
// ignore_for_file: type=lint
''',
    ),
    input: Input(
      entryPoints: [
        Uri.file(
          '$sdkPath/System/Library/Frameworks/Foundation.framework/Headers/NSURL.h',
        ),
      ],
      compilerOptions: ['-isysroot', sdkPath, '-target', 'arm64-apple-ios16.0'],
    ),
    objectiveC: const ObjectiveC(),
    visitors: [
      Visitor(
        global: (node) => node.isIncluded = globals.contains(node.originalName),
      ),
    ],
  ).generate();
}
