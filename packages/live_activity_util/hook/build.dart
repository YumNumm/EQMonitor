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

    // * Part 1: Compile Swift → デバイス用 .framework + シミュレータ用 .framework を作り、XCFramework にまとめる
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

    final simSdkResult = await Process.run('xcrun', [
      '--sdk',
      'iphonesimulator',
      '--show-sdk-path',
    ]);
    if (simSdkResult.exitCode != 0) {
      logger.error('iphonesimulator SDK not found: ${simSdkResult.stderr}');
      throw Exception('Failed to resolve iOS Simulator SDK');
    }
    final iosSimSdkPath = (simSdkResult.stdout as String).trim();
    logger.info('iOS Simulator SDK path: $iosSimSdkPath');

    const frameworkName = 'LiveActivityUtil';
    final swiftSourcePath = packageRoot
        .resolve(
          'ios/live_activity_util/Sources/live_activity_util/EQMLiveActivityUtil.swift',
        )
        .toFilePath();

    final frameworksOutDir = Directory.fromUri(
      packageRoot.resolve('../../app/ios/Runner/Frameworks/'),
    );
    if (!frameworksOutDir.existsSync()) {
      frameworksOutDir.createSync(recursive: true);
    }
    final oldPlainFw = Directory('${frameworksOutDir.path}/$frameworkName.framework');
    final oldXc = Directory('${frameworksOutDir.path}/$frameworkName.xcframework');
    if (oldPlainFw.existsSync()) {
      oldPlainFw.deleteSync(recursive: true);
    }
    if (oldXc.existsSync()) {
      oldXc.deleteSync(recursive: true);
    }

    final dylibDevicePath = buildDirectory.resolve('lib${frameworkName}_device.dylib');
    final swiftcDevice = await Process.run(
      'swiftc',
      [
        '-sdk',
        iosSdkPath,
        '-target',
        'arm64-apple-ios16.0',
        '-emit-objc-header',
        '-emit-objc-header-path',
        generatedHeaderPath.toFilePath(),
        '-emit-library',
        '-Xlinker',
        '-install_name',
        '-Xlinker',
        '@rpath/$frameworkName.framework/$frameworkName',
        '-o',
        dylibDevicePath.toFilePath(),
        '-module-name',
        'live_activity_util',
        swiftSourcePath,
      ],
      workingDirectory: packageRoot.toFilePath(),
    );

    if (swiftcDevice.exitCode != 0) {
      logger.error('swiftc (iphoneos) failed: ${swiftcDevice.stderr}');
      throw Exception('Failed to generate Objective-C header from Swift');
    }
    logger.info(
      'Generated Objective-C header: ${generatedHeaderPath.toFilePath()}',
    );

    final dylibSimArmPath = buildDirectory.resolve('lib${frameworkName}_sim_arm64.dylib');
    final swiftcSimArm = await Process.run(
      'swiftc',
      [
        '-sdk',
        iosSimSdkPath,
        '-target',
        'arm64-apple-ios16.0-simulator',
        '-emit-library',
        '-Xlinker',
        '-install_name',
        '-Xlinker',
        '@rpath/$frameworkName.framework/$frameworkName',
        '-o',
        dylibSimArmPath.toFilePath(),
        '-module-name',
        'live_activity_util',
        swiftSourcePath,
      ],
      workingDirectory: packageRoot.toFilePath(),
    );

    final dylibSimX86Path = buildDirectory.resolve('lib${frameworkName}_sim_x86.dylib');
    final swiftcSimX86 = await Process.run(
      'swiftc',
      [
        '-sdk',
        iosSimSdkPath,
        '-target',
        'x86_64-apple-ios16.0-simulator',
        '-emit-library',
        '-Xlinker',
        '-install_name',
        '-Xlinker',
        '@rpath/$frameworkName.framework/$frameworkName',
        '-o',
        dylibSimX86Path.toFilePath(),
        '-module-name',
        'live_activity_util',
        swiftSourcePath,
      ],
      workingDirectory: packageRoot.toFilePath(),
    );

    late final Uri dylibSimFinalPath;
    if (swiftcSimArm.exitCode == 0 && swiftcSimX86.exitCode == 0) {
      dylibSimFinalPath = buildDirectory.resolve('lib${frameworkName}_sim_universal.dylib');
      final lipoSim = await Process.run('lipo', [
        '-create',
        dylibSimArmPath.toFilePath(),
        dylibSimX86Path.toFilePath(),
        '-output',
        dylibSimFinalPath.toFilePath(),
      ]);
      if (lipoSim.exitCode != 0) {
        logger.error('lipo (simulator) failed: ${lipoSim.stderr}');
        throw Exception('Failed to lipo simulator dylibs');
      }
    } else if (swiftcSimArm.exitCode == 0) {
      logger.info('Using arm64-only iOS Simulator dylib (x86_64 swiftc unavailable)');
      dylibSimFinalPath = dylibSimArmPath;
    } else if (swiftcSimX86.exitCode == 0) {
      logger.info('Using x86_64-only iOS Simulator dylib (arm64 swiftc unavailable)');
      dylibSimFinalPath = dylibSimX86Path;
    } else {
      logger.error(
        'swiftc (simulator) failed. arm64: ${swiftcSimArm.stderr} x86: ${swiftcSimX86.stderr}',
      );
      throw Exception('Failed to compile Swift for iOS Simulator');
    }

    final deviceFwDir = Directory.fromUri(
      buildDirectory.resolve('xc_tmp/device/$frameworkName.framework/'),
    );
    final simFwDir = Directory.fromUri(
      buildDirectory.resolve('xc_tmp/sim/$frameworkName.framework/'),
    );
    deviceFwDir.createSync(recursive: true);
    simFwDir.createSync(recursive: true);

    const infoPlistContents = '''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>en</string>
  <key>CFBundleExecutable</key>
  <string>LiveActivityUtil</string>
  <key>CFBundleIdentifier</key>
  <string>net.yumnumm.live-activity-util</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>LiveActivityUtil</string>
  <key>CFBundlePackageType</key>
  <string>FMWK</string>
  <key>CFBundleVersion</key>
  <string>1.0</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>MinimumOSVersion</key>
  <string>16.0</string>
</dict>
</plist>
''';

    await File(dylibDevicePath.toFilePath()).copy('${deviceFwDir.path}/$frameworkName');
    File('${deviceFwDir.path}/Info.plist').writeAsStringSync(infoPlistContents);

    await File(dylibSimFinalPath.toFilePath()).copy('${simFwDir.path}/$frameworkName');
    File('${simFwDir.path}/Info.plist').writeAsStringSync(infoPlistContents);

    final xcframeworkOut = Directory('${frameworksOutDir.path}/$frameworkName.xcframework');
    final createXc = await Process.run('xcodebuild', [
      '-create-xcframework',
      '-framework',
      deviceFwDir.path,
      '-framework',
      simFwDir.path,
      '-output',
      xcframeworkOut.path,
    ]);
    if (createXc.exitCode != 0) {
      logger.error('xcodebuild -create-xcframework failed: ${createXc.stderr}');
      throw Exception('Failed to create LiveActivityUtil.xcframework');
    }
    logger.info('Created ${xcframeworkOut.path}');

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
      assetName: 'src/live_activity_util.dart',
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
