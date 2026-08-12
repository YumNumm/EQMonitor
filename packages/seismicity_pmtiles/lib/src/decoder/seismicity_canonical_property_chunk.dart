import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_fixed_columns.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_string_columns.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

typedef SeismicityCanonicalPropertyChunkData = ({
  SeismicityCanonicalFixedColumnData fixed,
  SeismicityCanonicalStringColumnData strings,
});

final class SeismicityCanonicalPropertyChunk {
  SeismicityCanonicalPropertyChunk({required int capacity})
    : _fixed = SeismicityCanonicalFixedColumns(capacity: capacity),
      _strings = SeismicityCanonicalStringColumns(capacity: capacity);

  final SeismicityCanonicalFixedColumns _fixed;
  final SeismicityCanonicalStringColumns _strings;

  int get length => _fixed.length;
  bool get isFull => _fixed.isFull;

  void add({required SeismicityDecodedHypocenter row}) {
    if (isFull) {
      throw const SeismicityPmTilesException.invalidDescriptor(
        reason: 'Canonical property chunk capacity exceeded.',
      );
    }
    _fixed.add(row: row);
    _strings.add(
      determinationFlagUtf8: row.determinationFlagUtf8,
      earthquakeEventIdUtf8: row.earthquakeEventIdUtf8,
    );
  }

  SeismicityCanonicalPropertyChunkData build() => (
    fixed: _fixed.build(),
    strings: _strings.build(),
  );
}
