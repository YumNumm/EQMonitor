import 'dart:io';

import 'package:jnigen/jnigen.dart';

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    stderr.writeln('usage: dart run tool/jnigen.dart <path to android.jar>');
    exit(64);
  }
  final packageRoot = Platform.script.resolve('../');
  await JniGenerator(
    input: Input(
      classPath: [File(args.single).absolute.uri],
      backend: SummarizerBackend.asm,
      classes: ['android.os.StatFs'],
    ),
    output: Output(
      dart: DartOutput(
        path: packageRoot.resolve(
          'lib/src/device_storage/android/android_bindings.g.dart',
        ),
        structure: OutputStructure.singleFile,
      ),
      preamble: '// ignore_for_file: type=lint',
    ),
  ).generate();
}
