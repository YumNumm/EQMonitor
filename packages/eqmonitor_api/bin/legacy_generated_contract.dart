import 'dart:io';

const legacyModelPrefixes = {
  'earthquake_station',
  'jma_code_table_',
  'kyoshin_observation_',
  'localized_name',
  'parameter_',
  'parameters_',
  'shindo_db_',
  'tsunami_station',
  'target_union',
  'post_v2_admin_test_',
  'v2_admin_test_',
};

const legacyGenericModels = {
  'environment.dart',
  'event_type.dart',
  'operation.dart',
  'operation2.dart',
  'type.dart',
  'type2.dart',
  'type3.dart',
  'type4.dart',
  'type5.dart',
};

bool isLegacyGeneratedContractPath({required String relativePath}) {
  if (relativePath.startsWith('clients/parameters_api_client')) {
    return true;
  }
  if (!relativePath.startsWith('models/')) {
    return false;
  }
  final name = relativePath.substring('models/'.length);
  return legacyGenericModels.contains(name) ||
      legacyModelPrefixes.any(name.startsWith);
}

Map<String, List<int>> preserveLegacyGeneratedContract({
  required Directory libDir,
}) => {
  for (final file in libDir.listSync(recursive: true).whereType<File>())
    if (isLegacyGeneratedContractPath(
      relativePath: file.path.substring(libDir.path.length + 1),
    ))
      file.path.substring(libDir.path.length + 1): file.readAsBytesSync(),
};

void restoreLegacyGeneratedContract({
  required Directory libDir,
  required Map<String, List<int>> preserved,
}) {
  for (final entry in preserved.entries) {
    final file = File('${libDir.path}/${entry.key}')
      ..createSync(recursive: true);
    file.writeAsBytesSync(entry.value);
  }
  patchLegacyApiClient(file: File('${libDir.path}/api_client.dart'));
  patchLegacyExports(file: File('${libDir.path}/export.dart'));
}

void patchLegacyApiClient({required File file}) {
  var source = file.readAsStringSync();
  source = insertAfterOnce(
    source: source,
    anchor: "import 'clients/hypocenters_api_client.dart';",
    addition: "import 'clients/parameters_api_client.dart';",
  );
  source = insertAfterOnce(
    source: source,
    anchor: '  HypocentersApiClient? _hypocenters;',
    addition: '  ParametersApiClient? _parameters;',
  );
  source = insertAfterOnce(
    source: source,
    anchor:
        '  HypocentersApiClient get hypocenters => _hypocenters ??= HypocentersApiClient(_dio, baseUrl: _baseUrl);',
    addition:
        '  ParametersApiClient get parameters => _parameters ??= ParametersApiClient(_dio, baseUrl: _baseUrl);',
  );
  file.writeAsStringSync(source);
}

void patchLegacyExports({required File file}) {
  var source = file.readAsStringSync();
  source = insertAfterOnce(
    source: source,
    anchor: "export 'clients/hypocenters_api_client.dart';",
    addition: "export 'clients/parameters_api_client.dart';",
  );
  final modelExports = file.parent.uri.resolve('models/').toFilePath();
  final exports =
      Directory(modelExports)
          .listSync()
          .whereType<File>()
          .where((candidate) {
            final name = candidate.uri.pathSegments.last;
            return isLegacyGeneratedContractPath(
                  relativePath: 'models/$name',
                ) &&
                name.endsWith('.dart') &&
                !name.endsWith('.g.dart') &&
                !name.endsWith('.freezed.dart');
          })
          .map((candidate) => candidate.uri.pathSegments.last)
          .toList()
        ..sort();
  for (final name in exports) {
    source = insertAfterOnce(
      source: source,
      anchor: "export 'models/hypocenter_service_unavailable_response.dart';",
      addition: "export 'models/$name';",
    );
  }
  file.writeAsStringSync(source);
}

String insertAfterOnce({
  required String source,
  required String anchor,
  required String addition,
}) {
  if (addition.isEmpty || source.contains(addition)) {
    return source;
  }
  if (!source.contains(anchor)) {
    throw StateError('Generated contract anchor was not found: $anchor');
  }
  return source.replaceFirst(anchor, '$anchor\n$addition');
}
