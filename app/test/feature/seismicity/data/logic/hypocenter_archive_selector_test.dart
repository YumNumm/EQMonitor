import 'package:eqmonitor/feature/seismicity/data/logic/hypocenter_archive_selector.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_partition.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final archives = [
    _archive(partition: .year, label: '2025'),
    _archive(partition: .day, label: '2026-08-01'),
    _archive(partition: .day, label: '2026-08-02'),
  ];

  test('最新のDAYだけを初期選択する', () {
    final selected = const HypocenterArchiveSelector().initialSelection(
      archives: archives,
    );

    expect(selected.single.id.jstLabel, '2026-08-02');
  });

  test('DAYがない場合にYEARへフォールバックしない', () {
    final selected = const HypocenterArchiveSelector().initialSelection(
      archives: [archives.first],
    );

    expect(selected, isEmpty);
  });

  test('URLと期間終端が変わっても論理IDで選択を引き継ぐ', () {
    const selectedId = HypocenterArchiveId(
      partition: HypocenterArchivePartition.year,
      jstLabel: '2025',
    );
    final refreshed = _archive(
      partition: .year,
      label: '2025',
      url: 'https://tiles.example/new.pmtiles',
      periodTo: DateTime.utc(2026),
    );

    final selected = const HypocenterArchiveSelector().remap(
      selected: {selectedId},
      archives: [refreshed],
    );

    expect(selected.single.url, endsWith('new.pmtiles'));
    expect(selected.single.periodTo, DateTime.utc(2026));
  });

  test('manifestから消えた選択を除外する', () {
    const missing = HypocenterArchiveId(
      partition: HypocenterArchivePartition.year,
      jstLabel: '2024',
    );

    final selected = const HypocenterArchiveSelector().remap(
      selected: {missing},
      archives: archives,
    );

    expect(selected, isEmpty);
  });
}

HypocenterArchive _archive({
  required HypocenterArchivePartition partition,
  required String label,
  String url = 'https://tiles.example/archive.pmtiles',
  DateTime? periodTo,
}) => HypocenterArchive(
  id: HypocenterArchiveId(partition: partition, jstLabel: label),
  periodFrom: DateTime.utc(2025),
  periodTo: periodTo ?? DateTime.utc(2025, 12, 31),
  url: url,
  featureCount: 1,
  sizeBytes: 128,
  queryRevision: '1234567890abcdef12345678',
);
