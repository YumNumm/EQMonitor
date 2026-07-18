import 'dart:io';

import 'package:jnigen/jnigen.dart';

Future<void> main() async {
  final packageRoot = Platform.script.resolve('../');
  await generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/src/android/assets_util_jni.g.dart'),
          structure: OutputStructure.singleFile,
        ),
      ),
      preamble: '// ignore_for_file: type=lint\n',
      androidSdkConfig: AndroidSdkConfig(
        addGradleDeps: true,
        androidExample: 'example/',
      ),
      sourcePath: [packageRoot.resolve('android/src/main/java')],
      classes: [
        'android.content.Context',
        'net.yumnumm.assets_util.AssetsUtil',
      ],
    ),
  );
}
