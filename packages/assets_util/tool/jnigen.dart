import 'dart:io';

import 'package:jnigen/jnigen.dart';

Future<void> main() async {
  final packageRoot = Platform.script.resolve('../');
  final classesJar = packageRoot.resolve(
    'example/build/assets_util/intermediates/compile_library_classes_jar/'
    'debug/bundleLibCompileToJarDebug/classes.jar',
  );
  if (!File.fromUri(classesJar).existsSync()) {
    stderr.writeln(
      'Missing $classesJar\n'
      'Build the example first: '
      '(cd packages/assets_util/example && flutter build apk --debug)',
    );
    exitCode = 1;
    return;
  }

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
      classPath: [classesJar],
      classes: [
        'android.content.Context',
        'net.yumnumm.assets_util.AssetsUtil',
      ],
    ),
  );
}
