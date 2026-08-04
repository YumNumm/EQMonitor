import 'package:flutter_scene/build_hooks.dart';
import 'package:hooks/hooks.dart';

Future<void> main(List<String> args) async {
  await build(args, (config, output) async {
    await buildMaterials(
      buildInput: config,
      buildOutput: output,
      materials: ['assets/map_spike.fmat'],
    );
  });
}
