import 'package:data_assets/data_assets.dart';
import 'package:flutter_scene/build_hooks.dart';
import 'package:hooks/hooks.dart';

Future<void> main(List<String> args) async {
  await build(args, (config, output) async {
    await buildMaterials(
      buildInput: config,
      buildOutput: output,
      materials: [
        'assets/base_map_fill.fmat',
        'assets/base_map_line.fmat',
        'assets/earthquake_area_fill.fmat',
      ],
    );
    if (config.config.buildDataAssets) {
      await buildTargetShaderBundleJson(
        buildInput: config,
        buildOutput: output,
        manifestFileName: 'shaders/earthquake_overlay.shaderbundle.json',
        assetMode: TargetShaderBundleAssetMode.dataAssetsRequired,
        glesLanguageVersion: 300,
      );
    }
  });
}
