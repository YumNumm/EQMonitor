import 'dart:io';

import 'package:jnigen/jnigen.dart';

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    stderr.writeln('usage: dart run tool/jnigen.dart <path to android.jar>');
    exit(64);
  }
  final packageRoot = Platform.script.resolve('../');
  await generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve(
            'lib/src/device_storage/android/android_bindings.g.dart',
          ),
          structure: OutputStructure.singleFile,
        ),
      ),
      preamble: '// ignore_for_file: type=lint',
      classPath: [File(args.single).absolute.uri],
      summarizerOptions: SummarizerOptions(backend: SummarizerBackend.asm),
      classes: ['android.os.StatFs'],
    ),
  );
}
