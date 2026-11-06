import 'dart:convert';

import 'package:crypto/crypto.dart';

class const NativeShakeModelBuilder() {
  Map<String, dynamic> build({
    required String csv,
    required Map<String, double> sites,
    required String catalogHash,
  }) {
    final cells = <(double, double), (double, double)>{};
    final depths = <double>{};
    final distances = <double>{};
    for (final line in const LineSplitter().convert(csv)) {
      if (line.trim().isEmpty) continue;
      final row = line.split(',').map(double.parse).toList();
      if (row.length != 4)
        throw const FormatException('Invalid travel table row');
      final key = (row[2], row[3]);
      if (cells.containsKey(key))
        throw const FormatException('Duplicate travel table cell');
      cells[key] = (row[0], row[1]);
      depths.add(row[2]);
      distances.add(row[3]);
    }
    final z = depths.toList()..sort();
    final x = distances.toList()..sort();
    final values = [
      for (final depth in z)
        for (final distance in x) cells[(depth, distance)],
    ];
    if (values.any((v) => v == null))
      throw const FormatException('Incomplete travel table');
    final payload = jsonEncode({
      'depths_km': z,
      'distances_km': x,
      'p_seconds': [for (final v in values.whereType<(double, double)>()) v.$1],
      's_seconds': [for (final v in values.whereType<(double, double)>()) v.$2],
      'site_amplification': sites,
    });
    final manifest = jsonEncode({
      'schema_version': 1,
      'version': 'JMA2001:$catalogHash',
      'units': 'km_seconds',
      'source': 'JMA2001 / observation catalogue VS400',
      'sha256': sha256.convert(utf8.encode(payload)).toString(),
    });
    return {'manifest_json': manifest, 'payload_json': payload};
  }
}
