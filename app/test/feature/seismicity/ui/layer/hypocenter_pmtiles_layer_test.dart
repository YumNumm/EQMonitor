import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/ui/layer/hypocenter_pmtiles_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final archive = HypocenterArchive(
    id: const HypocenterArchiveId(
      partition: HypocenterArchivePartition.day,
      jstLabel: '2026-08-02',
    ),
    periodFrom: _from,
    periodTo: _to,
    url: 'https://tiles.example/archive.pmtiles',
    featureCount: 100,
    sizeBytes: 1024,
    queryRevision: '1234567890abcdef12345678',
  );

  test('リモートURLへpmtiles schemeを一度だけ付与する', () {
    final source = const HypocenterPmTilesStyleBuilder().sourceFor(
      archive: archive,
    );

    expect(source.url, 'pmtiles://https://tiles.example/archive.pmtiles');
  });

  test('既にschemeがあるURLを二重化しない', () {
    final source = const HypocenterPmTilesStyleBuilder().sourceFor(
      archive: archive.copyWith(
        url: 'pmtiles://https://tiles.example/a.pmtiles',
      ),
    );

    expect(source.url, 'pmtiles://https://tiles.example/a.pmtiles');
  });

  test('zoom 7でclusterから個別震源へ切り替える', () {
    final bundle = const HypocenterPmTilesStyleBuilder().layersFor(
      archive: archive,
      colorMode: SeismicityColorMode.magnitude,
      now: DateTime.utc(2026, 8, 2),
    );

    expect(bundle.cluster.maxZoom, 7);
    expect(bundle.hypocenter.minZoom, 7);
    expect(bundle.cluster.sourceLayerId, 'clusters');
    expect(bundle.hypocenter.sourceLayerId, 'hypocenters');
  });
}

final _from = DateTime.utc(2026, 8, 1, 15);
final _to = DateTime.utc(2026, 8, 2, 15);
