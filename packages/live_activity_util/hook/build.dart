import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:ffigen/ffigen.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

import 'logger.dart';

final logger = Logger();

Future<void> main(List<String> args) => build(
  args,
  (input, output) async {
    if (!input.config.buildCodeAssets) {
      logger.warn('buildCodeAssets is disabled');
      return;
    }
    if (input.config.code.targetOS != OS.iOS) {
      logger.info('targetOS is not iOS, skip...');
      return;
    }
    if (input.config.code.linkModePreference == LinkModePreference.static) {
      logger.error('static linking is not supported');
      throw UnsupportedError('static linking is not supported');
    }

    final packageRoot = input.packageRoot;
    final buildDirectory = packageRoot.resolve('build/');

    logger.info('Package root: ${packageRoot.toFilePath()}');
    logger.info('Output root: ${buildDirectory.toFilePath()}');

    final libDir = Directory.fromUri(packageRoot.resolve('lib/src/'));
    if (!libDir.existsSync()) {
      libDir.createSync(recursive: true);
    }

    // * Part 1: Compile Swift to generate Objective-C header
    final generatedHeaderPath = buildDirectory.resolve(
      'lib/LiveActivityUtil.h',
    );

    final sdkPathResult = await Process.run('xcrun', [
      '--sdk',
      'iphoneos',
      '--show-sdk-path',
    ]);
    final iosSdkPath = (sdkPathResult.stdout as String).trim();
    logger.info('iOS SDK path: $iosSdkPath');

    // Compile Swift to generate Objective-C header
    final swiftcResult = await Process.run(
      'swiftc',
      [
        '-sdk',
        iosSdkPath,
        '-target', 'arm64-apple-ios16.0',
        '-emit-objc-header',
        '-emit-objc-header-path',
        generatedHeaderPath.toFilePath(),
        '-emit-library',
        '-o',
        // '/dev/null',
        '../../app/ios/Runner/Frameworks/libLiveActivityUtil.dylib',
        '-module-name',
        'live_activity_util',
        '-c',
        packageRoot
            .resolve(
              'ios/live_activity_util/Sources/live_activity_util/EQMLiveActivityUtil.swift',
            )
            .toFilePath(),
      ],
      workingDirectory: packageRoot.toFilePath(),
    );

    if (swiftcResult.exitCode != 0) {
      logger.error('swiftc failed: ${swiftcResult.stderr}');
      throw Exception('Failed to generate Objective-C header from Swift');
    }
    logger.info(
      'Generated Objective-C header: ${generatedHeaderPath.toFilePath()}',
    );

    // * Part 2: Generate Dart bindings using ffigen
    final ffiOutputDartFile = libDir.uri.resolve('live_activity_util.dart');
    final generator = FfiGenerator(
      output: Output(
        dartFile: ffiOutputDartFile,
        preamble: '''
// dart format off
// ignore_for_file: type=lint
''',
      ),
      headers: Headers(
        entryPoints: [generatedHeaderPath],
        compilerOptions: [
          '-isysroot',
          iosSdkPath,
          '-target',
          'arm64-apple-ios16.0',
        ],
      ),
      objectiveC: ObjectiveC(
        interfaces: Interfaces(
          includeMember: (declaration, member) => true,
          include: (declaration) =>
              declaration.originalName == 'EQMLiveActivityUtil' ||
              {'NSString', 'NSObject'}.contains(declaration.originalName),
        ),
        protocols: Protocols(
          include: (declaration) =>
              declaration.originalName == 'EQMLiveActivityUtil',
          module: (declaration) => <String, String>{}[declaration.originalName],
          includeMember: (declaration, member) => true,
        ),
      ),
      enums: Enums(
        style: (declaration, suggestedStyle) => EnumStyle.intConstants,
      ),
    );

    generator.generate();
    logger.info(
      'Generated Dart bindings: ${generator.output.dartFile.toFilePath()}',
    );

    // Step 3: Compile Objective-C glue code
    final objcSourcePath = libDir.uri.resolve('live_activity_util.dart.m');
    final cBuilder = CBuilder.library(
      name: 'live_activity_util',
      assetName: 'live_activity_util.g.dart',
      sources: [
        objcSourcePath.toFilePath(),
      ],
      language: Language.objectiveC,
      includes: [],
      flags: [
        '-fobjc-arc',
      ],
      frameworks: ['Foundation', 'ActivityKit'],
    );
    await cBuilder.run(input: input, output: output);
  },
);
