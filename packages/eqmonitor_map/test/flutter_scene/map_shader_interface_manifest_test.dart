import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/flutter_scene/map_shader_interface_manifest.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'defensively parses typed input, uniform, and sampled-image metadata',
    () {
      final bytes = Uint8List.fromList(
        utf8.encode('''
{
  "version": 1,
  "shaders": {
    "MapSpriteVertex": {
      "stage": "vertex",
      "inputs": [
        {
          "name": "corner", "location": 0, "set": 0, "binding": 0,
          "type": "float", "bitWidth": 32, "vecSize": 2,
          "columns": 1, "offset": 0
        }
      ],
      "uniformBlocks": [
        {
          "name": "SpriteFrame", "set": 0, "binding": 0,
          "sizeInBytes": 64,
          "fields": [
            {
              "name": "cameraWorld", "type": "float",
              "offsetInBytes": 0, "elementSizeInBytes": 4,
              "totalSizeInBytes": 16, "arrayElements": 0,
              "vecSize": 4, "columns": 1
            }
          ]
        }
      ],
      "sampledImages": [
        {"name": "spriteAtlas", "set": 0, "binding": 2}
      ]
    }
  }
}
'''),
      );
      final manifest = MapShaderInterfaceManifest.parse(jsonBytes: bytes);
      bytes.fillRange(0, bytes.length, 0);

      final shader = manifest.shaderNamed(mapSpriteVertexShaderSymbol);
      expect(shader.stage, MapShaderInterfaceStage.vertex);
      expect(shader.inputs.single.name, 'corner');
      expect(shader.inputs.single.type, MapShaderScalarType.float);
      expect(shader.inputs.single.vecSize, 2);
      expect(shader.uniformBlocks.single.sizeInBytes, 64);
      expect(shader.uniformBlocks.single.fields.single.offsetInBytes, 0);
      expect(shader.sampledImages.single.name, mapSpriteAtlasUniformName);
      expect(shader.sampledImages.single.set, 0);
      expect(shader.sampledImages.single.binding, 2);
    },
  );

  test(
    'rejects malformed roots, empty manifests, and unknown types',
    () {
      for (final source in [
        '[]',
        '{"version":2,"shaders":{}}',
        '{"version":1,"shaders":{}}',
        '''
      {"version":1,"shaders":{"a":{
        "stage":"vertex",
        "inputs":[{"name":"x","location":0,"set":0,"binding":0,
          "type":"vec2","bitWidth":32,"vecSize":2,"columns":1,
          "offset":0}],
        "uniformBlocks":[],"sampledImages":[]
      }}}
      ''',
      ]) {
        expect(
          () => MapShaderInterfaceManifest.parse(
            jsonBytes: Uint8List.fromList(utf8.encode(source)),
          ),
          throwsFormatException,
        );
      }
    },
  );

  test(
    'checked-in manifest exposes the sprite ABI without sampler type claims',
    () {
      final manifest = MapShaderInterfaceManifest.parse(
        jsonBytes: File(
          'shaders/earthquake_overlay.shaderinterface.json',
        ).readAsBytesSync(),
      );
      final vertex = manifest.shaderNamed(mapSpriteVertexShaderSymbol);
      final fragment = manifest.shaderNamed(mapSpriteFragmentShaderSymbol);

      expect(vertex.uniformBlocks.single.name, mapSpriteFrameUniformBlockName);
      expect(vertex.uniformBlocks.single.sizeInBytes, 64);
      expect(
        {for (final input in vertex.inputs) input.name: input.offset},
        {
          'corner': 0,
          'centerMercator': 8,
          'uvRect': 16,
          'logicalSize': 32,
          'opacity': 40,
          'priority': 44,
        },
      );
      expect(fragment.sampledImages.single.name, mapSpriteAtlasUniformName);
      expect(fragment.sampledImages.single.set, 0);
      expect(fragment.sampledImages.single.binding, 64);
    },
  );

  test('fragment source declares exactly one plain sampler2D atlas', () {
    final source = File('assets/earthquake_sprite.frag').readAsStringSync();
    final declarations = RegExp(
      r'^\s*uniform\s+(\w+)\s+spriteAtlas\s*;\s*$',
      multiLine: true,
    ).allMatches(source).toList();

    expect(declarations, hasLength(1));
    expect(declarations.single.group(1), 'sampler2D');
    expect(source, isNot(contains('samplerCube spriteAtlas')));
    expect(source, isNot(contains('sampler2DArray spriteAtlas')));
  });
}
