import 'dart:convert';
import 'dart:typed_data';

enum MapShaderInterfaceStage { vertex, fragment, compute }

enum MapShaderScalarType {
  boolean,
  signedByte,
  unsignedByte,
  signedShort,
  unsignedShort,
  signedInt,
  unsignedInt,
  signedInt64,
  unsignedInt64,
  halfFloat,
  float,
  double,
  sampledImage,
}

final class MapShaderInputInterface {
  const MapShaderInputInterface({
    required this.name,
    required this.location,
    required this.set,
    required this.binding,
    required this.type,
    required this.bitWidth,
    required this.vecSize,
    required this.columns,
    required this.offset,
  });

  final String name;
  final int location;
  final int set;
  final int binding;
  final MapShaderScalarType type;
  final int bitWidth;
  final int vecSize;
  final int columns;
  final int offset;
}

final class MapShaderUniformFieldInterface {
  const MapShaderUniformFieldInterface({
    required this.name,
    required this.type,
    required this.offsetInBytes,
    required this.elementSizeInBytes,
    required this.totalSizeInBytes,
    required this.arrayElements,
    required this.vecSize,
    required this.columns,
  });

  final String name;
  final MapShaderScalarType type;
  final int offsetInBytes;
  final int elementSizeInBytes;
  final int totalSizeInBytes;
  final int arrayElements;
  final int vecSize;
  final int columns;
}

final class MapShaderUniformBlockInterface {
  const MapShaderUniformBlockInterface({
    required this.name,
    required this.set,
    required this.binding,
    required this.sizeInBytes,
    required this.fields,
  });

  final String name;
  final int set;
  final int binding;
  final int sizeInBytes;
  final List<MapShaderUniformFieldInterface> fields;
}

/// Sampled-image reflection intentionally contains no sampler dimension.
///
/// `sampler2D` is guaranteed by the checked-in source declaration test and
/// compiler success, not by unavailable runtime or bundle reflection.
final class MapShaderSampledImageInterface {
  const MapShaderSampledImageInterface({
    required this.name,
    required this.set,
    required this.binding,
  });

  final String name;
  final int set;
  final int binding;
}

final class MapShaderInterface {
  const MapShaderInterface({
    required this.stage,
    required this.inputs,
    required this.uniformBlocks,
    required this.sampledImages,
  });

  final MapShaderInterfaceStage stage;
  final List<MapShaderInputInterface> inputs;
  final List<MapShaderUniformBlockInterface> uniformBlocks;
  final List<MapShaderSampledImageInterface> sampledImages;
}

final class MapShaderInterfaceManifest {
  const MapShaderInterfaceManifest._({required this.shaders});

  factory MapShaderInterfaceManifest.parse({required Uint8List jsonBytes}) =>
      parseMapShaderInterfaceManifest(jsonBytes: jsonBytes);

  final Map<String, MapShaderInterface> shaders;

  MapShaderInterface shaderNamed(String name) {
    final shader = shaders[name];
    if (shader == null) {
      throw ArgumentError.value(name, 'name', 'is not declared');
    }
    return shader;
  }
}

MapShaderInterfaceManifest parseMapShaderInterfaceManifest({
  required Uint8List jsonBytes,
}) {
  final decoded = jsonDecode(utf8.decode(jsonBytes, allowMalformed: false));
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Shader interface manifest must be an object.');
  }
  _expectKeys(decoded, const {'version', 'shaders'}, 'manifest');
  if (decoded['version'] != 1) {
    throw const FormatException('Shader interface manifest version must be 1.');
  }
  final shaderValues = _mapField(decoded, 'shaders', 'shaders');
  if (shaderValues.isEmpty) {
    throw const FormatException(
      'Shader interface manifest must declare at least one shader.',
    );
  }
  final shaders = <String, MapShaderInterface>{};
  for (final entry in shaderValues.entries) {
    _nonBlank(entry.key, 'shaders.name');
    final shaderValue = entry.value;
    if (shaderValue is! Map<String, dynamic>) {
      throw FormatException('${entry.key} must be an object.');
    }
    shaders[entry.key] = _parseShader(shaderValue);
  }
  return MapShaderInterfaceManifest._(
    shaders: Map<String, MapShaderInterface>.unmodifiable(shaders),
  );
}

MapShaderInterface _parseShader(Map<String, dynamic> value) {
  _expectKeys(
    value,
    const {'stage', 'inputs', 'uniformBlocks', 'sampledImages'},
    'shader',
  );
  return MapShaderInterface(
    stage: _stage(_stringField(value, 'stage', 'stage')),
    inputs: _parseNamedList(
      parent: value,
      key: 'inputs',
      parameterName: 'inputs',
      parse: _parseInput,
      nameOf: (input) => input.name,
    ),
    uniformBlocks: _parseNamedList(
      parent: value,
      key: 'uniformBlocks',
      parameterName: 'uniformBlocks',
      parse: _parseUniformBlock,
      nameOf: (uniform) => uniform.name,
    ),
    sampledImages: _parseNamedList(
      parent: value,
      key: 'sampledImages',
      parameterName: 'sampledImages',
      parse: _parseSampledImage,
      nameOf: (image) => image.name,
    ),
  );
}

MapShaderInputInterface _parseInput(Map<String, dynamic> value) {
  _expectKeys(value, const {
    'name',
    'location',
    'set',
    'binding',
    'type',
    'bitWidth',
    'vecSize',
    'columns',
    'offset',
  }, 'input');
  return MapShaderInputInterface(
    name: _nonBlank(
      _stringField(value, 'name', 'input.name'),
      'input.name',
    ),
    location: _nonNegativeIntField(value, 'location', 'input.location'),
    set: _nonNegativeIntField(value, 'set', 'input.set'),
    binding: _nonNegativeIntField(value, 'binding', 'input.binding'),
    type: _scalarType(_stringField(value, 'type', 'input.type')),
    bitWidth: _positiveIntField(value, 'bitWidth', 'input.bitWidth'),
    vecSize: _positiveIntField(value, 'vecSize', 'input.vecSize'),
    columns: _positiveIntField(value, 'columns', 'input.columns'),
    offset: _nonNegativeIntField(value, 'offset', 'input.offset'),
  );
}

MapShaderUniformBlockInterface _parseUniformBlock(
  Map<String, dynamic> value,
) {
  _expectKeys(
    value,
    const {'name', 'set', 'binding', 'sizeInBytes', 'fields'},
    'uniformBlock',
  );
  return MapShaderUniformBlockInterface(
    name: _nonBlank(
      _stringField(value, 'name', 'uniformBlock.name'),
      'uniformBlock.name',
    ),
    set: _nonNegativeIntField(value, 'set', 'uniformBlock.set'),
    binding: _nonNegativeIntField(value, 'binding', 'uniformBlock.binding'),
    sizeInBytes: _positiveIntField(
      value,
      'sizeInBytes',
      'uniformBlock.sizeInBytes',
    ),
    fields: _parseNamedList(
      parent: value,
      key: 'fields',
      parameterName: 'uniformBlock.fields',
      parse: _parseUniformField,
      nameOf: (field) => field.name,
    ),
  );
}

MapShaderUniformFieldInterface _parseUniformField(
  Map<String, dynamic> value,
) {
  _expectKeys(value, const {
    'name',
    'type',
    'offsetInBytes',
    'elementSizeInBytes',
    'totalSizeInBytes',
    'arrayElements',
    'vecSize',
    'columns',
  }, 'uniformField');
  return MapShaderUniformFieldInterface(
    name: _nonBlank(
      _stringField(value, 'name', 'uniformField.name'),
      'uniformField.name',
    ),
    type: _scalarType(_stringField(value, 'type', 'uniformField.type')),
    offsetInBytes: _nonNegativeIntField(
      value,
      'offsetInBytes',
      'uniformField.offsetInBytes',
    ),
    elementSizeInBytes: _positiveIntField(
      value,
      'elementSizeInBytes',
      'uniformField.elementSizeInBytes',
    ),
    totalSizeInBytes: _positiveIntField(
      value,
      'totalSizeInBytes',
      'uniformField.totalSizeInBytes',
    ),
    arrayElements: _nonNegativeIntField(
      value,
      'arrayElements',
      'uniformField.arrayElements',
    ),
    vecSize: _positiveIntField(value, 'vecSize', 'uniformField.vecSize'),
    columns: _positiveIntField(value, 'columns', 'uniformField.columns'),
  );
}

MapShaderSampledImageInterface _parseSampledImage(
  Map<String, dynamic> value,
) {
  _expectKeys(value, const {'name', 'set', 'binding'}, 'sampledImage');
  return MapShaderSampledImageInterface(
    name: _nonBlank(
      _stringField(value, 'name', 'sampledImage.name'),
      'sampledImage.name',
    ),
    set: _nonNegativeIntField(value, 'set', 'sampledImage.set'),
    binding: _nonNegativeIntField(value, 'binding', 'sampledImage.binding'),
  );
}

List<T> _parseNamedList<T>({
  required Map<String, dynamic> parent,
  required String key,
  required String parameterName,
  required T Function(Map<String, dynamic>) parse,
  required String Function(T) nameOf,
}) {
  final value = parent[key];
  if (value is! List) {
    throw FormatException('$parameterName must be a list.');
  }
  final result = <T>[];
  final names = <String>{};
  for (final item in value) {
    if (item is! Map<String, dynamic>) {
      throw FormatException('$parameterName entries must be objects.');
    }
    final parsed = parse(item);
    if (!names.add(nameOf(parsed))) {
      throw FormatException('$parameterName contains duplicate names.');
    }
    result.add(parsed);
  }
  return List<T>.unmodifiable(result);
}

Map<String, dynamic> _mapField(
  Map<String, dynamic> parent,
  String key,
  String parameterName,
) {
  final value = parent[key];
  if (value is! Map<String, dynamic>) {
    throw FormatException('$parameterName must be an object.');
  }
  return value;
}

String _stringField(
  Map<String, dynamic> parent,
  String key,
  String parameterName,
) {
  final value = parent[key];
  if (value is! String) {
    throw FormatException('$parameterName must be a string.');
  }
  return value;
}

int _nonNegativeIntField(
  Map<String, dynamic> parent,
  String key,
  String parameterName,
) {
  final value = parent[key];
  if (value is! int || value < 0) {
    throw FormatException('$parameterName must be a non-negative integer.');
  }
  return value;
}

int _positiveIntField(
  Map<String, dynamic> parent,
  String key,
  String parameterName,
) {
  final result = _nonNegativeIntField(parent, key, parameterName);
  if (result == 0) {
    throw FormatException('$parameterName must be positive.');
  }
  return result;
}

String _nonBlank(String value, String parameterName) {
  if (value.trim().isEmpty) {
    throw FormatException('$parameterName must not be blank.');
  }
  return value;
}

void _expectKeys(
  Map<String, dynamic> value,
  Set<String> expected,
  String parameterName,
) {
  if (value.keys.toSet().difference(expected).isNotEmpty ||
      expected.difference(value.keys.toSet()).isNotEmpty) {
    throw FormatException('$parameterName has an invalid shape.');
  }
}

MapShaderInterfaceStage _stage(String value) => switch (value) {
  'vertex' => MapShaderInterfaceStage.vertex,
  'fragment' => MapShaderInterfaceStage.fragment,
  'compute' => MapShaderInterfaceStage.compute,
  _ => throw FormatException('Unknown shader stage $value.'),
};

MapShaderScalarType _scalarType(String value) => switch (value) {
  'boolean' => MapShaderScalarType.boolean,
  'signedByte' => MapShaderScalarType.signedByte,
  'unsignedByte' => MapShaderScalarType.unsignedByte,
  'signedShort' => MapShaderScalarType.signedShort,
  'unsignedShort' => MapShaderScalarType.unsignedShort,
  'signedInt' => MapShaderScalarType.signedInt,
  'unsignedInt' => MapShaderScalarType.unsignedInt,
  'signedInt64' => MapShaderScalarType.signedInt64,
  'unsignedInt64' => MapShaderScalarType.unsignedInt64,
  'halfFloat' => MapShaderScalarType.halfFloat,
  'float' => MapShaderScalarType.float,
  'double' => MapShaderScalarType.double,
  'sampledImage' => MapShaderScalarType.sampledImage,
  _ => throw FormatException('Unknown shader scalar type $value.'),
};
