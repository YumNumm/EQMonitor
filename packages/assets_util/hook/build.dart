import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:ffigen/ffigen.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

import 'logger.dart';

final logger = Logger();

const frameworkName = 'AssetsUtil';

Future<void> main(List<String> args) => build(
  args,
  (input, output) async {
    if (!input.config.buildCodeAssets) {
      logger.warn('buildCodeAssets is disabled');
      return;
    }
    final targetOS = input.config.code.targetOS;
    if (targetOS != OS.iOS && targetOS != OS.macOS) {
      logger.info('targetOS is not iOS/macOS, skip...');
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

    final libDir = Directory.fromUri(packageRoot.resolve('lib/src/ios/'));
    if (!libDir.existsSync()) {
      libDir.createSync(recursive: true);
    }

    final swiftSourcePath = packageRoot
        .resolve('ios/assets_util/Sources/assets_util/EQMAssetsUtil.swift')
        .toFilePath();

    final generatedHeaderPath = buildDirectory.resolve('lib/AssetsUtil.h');

    // * Part 1: Compile Swift → platform-specific .framework(s), bundled
    // into an XCFramework, and copied to the app's native Frameworks dir.
    if (targetOS == OS.iOS) {
      await _buildIosXcframework(
        packageRoot: packageRoot,
        buildDirectory: buildDirectory,
        swiftSourcePath: swiftSourcePath,
        generatedHeaderPath: generatedHeaderPath,
      );
    } else {
      await _buildMacosXcframework(
        packageRoot: packageRoot,
        buildDirectory: buildDirectory,
        swiftSourcePath: swiftSourcePath,
        generatedHeaderPath: generatedHeaderPath,
      );
    }

    // * Part 2: Generate Dart bindings using ffigen. The generated
    // Objective-C header's selectors are identical whether it came from the
    // iOS or macOS compile above (same Swift source, same `@objc` surface;
    // only the `#if os(...)`-gated *implementation* differs), so a single
    // generated Dart bindings file works for both platforms.
    final ffiOutputDartFile = libDir.uri.resolve('eqm_assets_util.dart');
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
          switch (targetOS) {
            OS.iOS => await _sdkPath('iphoneos'),
            _ => await _sdkPath('macosx'),
          },
          '-target',
          switch (targetOS) {
            OS.iOS => 'arm64-apple-ios16.0',
            _ => 'arm64-apple-macosx15.6',
          },
        ],
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
    final generatedBinding = File.fromUri(ffiOutputDartFile);
    final normalizedBinding = generatedBinding
        .readAsLinesSync()
        .map((line) => line.trimRight())
        .join('\n');
    generatedBinding.writeAsStringSync('$normalizedBinding\n');
    logger.info(
      'Generated Dart bindings: ${generator.output.dartFile.toFilePath()}',
    );

    // Step 3: Compile Objective-C glue code
    final objcSourcePath = libDir.uri.resolve('eqm_assets_util.dart.m');
    final cBuilder = CBuilder.library(
      name: 'assets_util',
      assetName: 'src/ios/eqm_assets_util.dart',
      sources: [
        objcSourcePath.toFilePath(),
      ],
      language: Language.objectiveC,
      includes: [],
      flags: [
        '-fobjc-arc',
      ],
      frameworks: ['Foundation'],
    );
    await cBuilder.run(input: input, output: output);
  },
);

Future<String> _sdkPath(String sdk) async {
  final result = await Process.run('xcrun', ['--sdk', sdk, '--show-sdk-path']);
  return (result.stdout as String).trim();
}

/// * iOS: device .framework + simulator .framework (arm64 + x86_64 lipo'd
/// together, falling back to whichever slice compiled if only one did) →
/// XCFramework, copied to `app/ios/Runner/Frameworks/`.
Future<void> _buildIosXcframework({
  required Uri packageRoot,
  required Uri buildDirectory,
  required String swiftSourcePath,
  required Uri generatedHeaderPath,
}) async {
  final iosSdkPath = await _sdkPath('iphoneos');
  logger.info('iOS SDK path: $iosSdkPath');

  final iosSimSdkPath = await _sdkPath('iphonesimulator');
  logger.info('iOS Simulator SDK path: $iosSimSdkPath');

  final frameworksOutDir = Directory.fromUri(
    packageRoot.resolve('../../app/ios/Runner/Frameworks/'),
  );
  if (!frameworksOutDir.existsSync()) {
    frameworksOutDir.createSync(recursive: true);
  }
  _removeIfExists(
    Directory('${frameworksOutDir.path}/$frameworkName.framework'),
  );
  _removeIfExists(
    Directory('${frameworksOutDir.path}/$frameworkName.xcframework'),
  );

  final dylibDevicePath = buildDirectory.resolve(
    'lib${frameworkName}_device.dylib',
  );
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
      'assets_util',
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

  final dylibSimArmPath = buildDirectory.resolve(
    'lib${frameworkName}_sim_arm64.dylib',
  );
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
      'assets_util',
      swiftSourcePath,
    ],
    workingDirectory: packageRoot.toFilePath(),
  );

  final dylibSimX86Path = buildDirectory.resolve(
    'lib${frameworkName}_sim_x86.dylib',
  );
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
      'assets_util',
      swiftSourcePath,
    ],
    workingDirectory: packageRoot.toFilePath(),
  );

  final dylibSimFinalPath = await _lipoOrFallback(
    armPath: dylibSimArmPath,
    armResult: swiftcSimArm,
    x86Path: dylibSimX86Path,
    x86Result: swiftcSimX86,
    outputPath: buildDirectory.resolve(
      'lib${frameworkName}_sim_universal.dylib',
    ),
    label: 'simulator',
  );

  final deviceFwDir = Directory.fromUri(
    buildDirectory.resolve('xc_tmp/device/$frameworkName.framework/'),
  );
  final simFwDir = Directory.fromUri(
    buildDirectory.resolve('xc_tmp/sim/$frameworkName.framework/'),
  );
  deviceFwDir.createSync(recursive: true);
  simFwDir.createSync(recursive: true);

  final infoPlistContents = _frameworkInfoPlist(minimumOSVersion: '16.0');

  await File(
    dylibDevicePath.toFilePath(),
  ).copy('${deviceFwDir.path}/$frameworkName');
  File('${deviceFwDir.path}/Info.plist').writeAsStringSync(infoPlistContents);

  await File(
    dylibSimFinalPath.toFilePath(),
  ).copy('${simFwDir.path}/$frameworkName');
  File('${simFwDir.path}/Info.plist').writeAsStringSync(infoPlistContents);

  final xcframeworkOut = Directory(
    '${frameworksOutDir.path}/$frameworkName.xcframework',
  );
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
    throw Exception('Failed to create AssetsUtil.xcframework (iOS)');
  }
  logger.info('Created ${xcframeworkOut.path}');
}

/// * macOS: single arm64+x86_64 universal .framework, wrapped in an
/// XCFramework (reuses the same `xcodebuild -create-xcframework` tooling
/// already proven for iOS, rather than hand-assembling a versioned
/// framework bundle), copied to `app/macos/Runner/Frameworks/`.
Future<void> _buildMacosXcframework({
  required Uri packageRoot,
  required Uri buildDirectory,
  required String swiftSourcePath,
  required Uri generatedHeaderPath,
}) async {
  final macosSdkPath = await _sdkPath('macosx');
  logger.info('macOS SDK path: $macosSdkPath');

  final frameworksOutDir = Directory.fromUri(
    packageRoot.resolve('../../app/macos/Runner/Frameworks/'),
  );
  if (!frameworksOutDir.existsSync()) {
    frameworksOutDir.createSync(recursive: true);
  }
  _removeIfExists(
    Directory('${frameworksOutDir.path}/$frameworkName.framework'),
  );
  _removeIfExists(
    Directory('${frameworksOutDir.path}/$frameworkName.xcframework'),
  );

  // Runner's actual MACOSX_DEPLOYMENT_TARGET (app/macos/Runner.xcodeproj).
  const macosTarget = 'macosx15.6';

  final dylibArmPath = buildDirectory.resolve(
    'lib${frameworkName}_macos_arm64.dylib',
  );
  final swiftcArm = await Process.run(
    'swiftc',
    [
      '-sdk',
      macosSdkPath,
      '-target',
      'arm64-apple-$macosTarget',
      '-emit-objc-header',
      '-emit-objc-header-path',
      generatedHeaderPath.toFilePath(),
      '-emit-library',
      '-Xlinker',
      '-install_name',
      '-Xlinker',
      '@rpath/$frameworkName.framework/$frameworkName',
      '-o',
      dylibArmPath.toFilePath(),
      '-module-name',
      'assets_util',
      swiftSourcePath,
    ],
    workingDirectory: packageRoot.toFilePath(),
  );
  if (swiftcArm.exitCode != 0) {
    logger.error('swiftc (macosx, arm64) failed: ${swiftcArm.stderr}');
    throw Exception('Failed to compile Swift for macOS (arm64)');
  }
  logger.info(
    'Generated Objective-C header: ${generatedHeaderPath.toFilePath()}',
  );

  final dylibX86Path = buildDirectory.resolve(
    'lib${frameworkName}_macos_x86.dylib',
  );
  final swiftcX86 = await Process.run(
    'swiftc',
    [
      '-sdk',
      macosSdkPath,
      '-target',
      'x86_64-apple-$macosTarget',
      '-emit-library',
      '-Xlinker',
      '-install_name',
      '-Xlinker',
      '@rpath/$frameworkName.framework/$frameworkName',
      '-o',
      dylibX86Path.toFilePath(),
      '-module-name',
      'assets_util',
      swiftSourcePath,
    ],
    workingDirectory: packageRoot.toFilePath(),
  );

  final dylibFinalPath = await _lipoOrFallback(
    armPath: dylibArmPath,
    armResult: swiftcArm,
    x86Path: dylibX86Path,
    x86Result: swiftcX86,
    outputPath: buildDirectory.resolve(
      'lib${frameworkName}_macos_universal.dylib',
    ),
    label: 'macOS',
  );

  final macFwDir = Directory.fromUri(
    buildDirectory.resolve('xc_tmp/macos/$frameworkName.framework/'),
  );
  macFwDir.createSync(recursive: true);
  await File(
    dylibFinalPath.toFilePath(),
  ).copy('${macFwDir.path}/$frameworkName');
  File('${macFwDir.path}/Info.plist').writeAsStringSync(
    _frameworkInfoPlist(minimumOSVersion: '15.6'),
  );

  final xcframeworkOut = Directory(
    '${frameworksOutDir.path}/$frameworkName.xcframework',
  );
  final createXc = await Process.run('xcodebuild', [
    '-create-xcframework',
    '-framework',
    macFwDir.path,
    '-output',
    xcframeworkOut.path,
  ]);
  if (createXc.exitCode != 0) {
    logger.warn(
      'xcodebuild -create-xcframework unavailable; '
      'assembling the deterministic macOS wrapper directly.',
    );
    await _assembleMacOSXCFramework(
      framework: macFwDir,
      output: xcframeworkOut,
      architectures: [
        if (swiftcArm.exitCode == 0) 'arm64',
        if (swiftcX86.exitCode == 0) 'x86_64',
      ],
    );
  }
  logger.info('Created ${xcframeworkOut.path}');
}

Future<void> _assembleMacOSXCFramework({
  required Directory framework,
  required Directory output,
  required List<String> architectures,
}) async {
  final identifier = 'macos-${architectures.join('_')}';
  final destination = Directory(
    '${output.path}/$identifier/AssetsUtil.framework',
  );
  destination.createSync(recursive: true);
  await File(
    '${framework.path}/AssetsUtil',
  ).copy('${destination.path}/AssetsUtil');
  await File(
    '${framework.path}/Info.plist',
  ).copy('${destination.path}/Info.plist');
  final architectureEntries = architectures
      .map((architecture) => '        <string>$architecture</string>')
      .join('\n');
  File('${output.path}/Info.plist').writeAsStringSync('''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>AvailableLibraries</key>
  <array>
    <dict>
      <key>BinaryPath</key>
      <string>AssetsUtil.framework/AssetsUtil</string>
      <key>LibraryIdentifier</key>
      <string>$identifier</string>
      <key>LibraryPath</key>
      <string>AssetsUtil.framework</string>
      <key>SupportedArchitectures</key>
      <array>
$architectureEntries
      </array>
      <key>SupportedPlatform</key>
      <string>macos</string>
    </dict>
  </array>
  <key>CFBundlePackageType</key>
  <string>XFWK</string>
  <key>XCFrameworkFormatVersion</key>
  <string>1.0</string>
</dict>
</plist>
''');
}

/// Lipo's the arm64/x86_64 dylibs together if both compiled; otherwise
/// falls back to whichever single slice succeeded (mirrors the existing
/// iOS-simulator fallback behavior for machines missing one Swift target).
Future<Uri> _lipoOrFallback({
  required Uri armPath,
  required ProcessResult armResult,
  required Uri x86Path,
  required ProcessResult x86Result,
  required Uri outputPath,
  required String label,
}) async {
  if (armResult.exitCode == 0 && x86Result.exitCode == 0) {
    final lipo = await Process.run('lipo', [
      '-create',
      armPath.toFilePath(),
      x86Path.toFilePath(),
      '-output',
      outputPath.toFilePath(),
    ]);
    if (lipo.exitCode != 0) {
      logger.error('lipo ($label) failed: ${lipo.stderr}');
      throw Exception('Failed to lipo $label dylibs');
    }
    return outputPath;
  } else if (armResult.exitCode == 0) {
    logger.info('Using arm64-only $label dylib (x86_64 swiftc unavailable)');
    return armPath;
  } else if (x86Result.exitCode == 0) {
    logger.info('Using x86_64-only $label dylib (arm64 swiftc unavailable)');
    return x86Path;
  } else {
    logger.error(
      'swiftc ($label) failed. '
      'arm64: ${armResult.stderr} x86: ${x86Result.stderr}',
    );
    throw Exception('Failed to compile Swift for $label');
  }
}

void _removeIfExists(FileSystemEntity entity) {
  if (entity.existsSync()) {
    entity.deleteSync(recursive: true);
  }
}

String _frameworkInfoPlist({required String minimumOSVersion}) =>
    '''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>en</string>
  <key>CFBundleExecutable</key>
  <string>AssetsUtil</string>
  <key>CFBundleIdentifier</key>
  <string>net.yumnumm.assets-util</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>AssetsUtil</string>
  <key>CFBundlePackageType</key>
  <string>FMWK</string>
  <key>CFBundleVersion</key>
  <string>1.0</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>MinimumOSVersion</key>
  <string>$minimumOSVersion</string>
</dict>
</plist>
''';
