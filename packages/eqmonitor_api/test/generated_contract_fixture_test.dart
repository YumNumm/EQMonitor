import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

const _eventId = '20260823020050';
const _sizeBytes = 1013133;
const _sha256 =
    '86eecccd44b812c294b8d06e6224a373bede507ce21bd5380535ae0ae7eda2aa';
const _legacyUrl =
    'https://tiles.eqmonitor.app/ixac41/20260823020050/'
    '86eecccd44b812c294b8d06e6224a373bede507ce21bd5380535ae0ae7eda2aa.pmtiles';

void main() {
  test('listとdetail fixtureが同じ推計震度archive descriptorを復元する', () {
    final listJson = jsonDecode(
      File(
        'test/fixtures/contract/'
        'get__v2_earthquake__estimated-intensity-archive.json',
      ).readAsStringSync(),
    ) as Map<String, Object?>;
    final detailJson = jsonDecode(
      File(
        'test/fixtures/contract/'
        'get__v2_earthquake_eventId__estimated-intensity-archive.json',
      ).readAsStringSync(),
    ) as Map<String, Object?>;

    final listEarthquake = EarthquakeListResponse.fromJson(listJson)
        .items
        .single;
    final detailEarthquake = EarthquakeDetailResponse.fromJson(detailJson)
        .earthquake;
    final listArchive = listEarthquake.estimatedIntensityTileArchive;
    final detailArchive = detailEarthquake.estimatedIntensityTileArchive;

    expect(listEarthquake.eventId, _eventId);
    expect(detailEarthquake.eventId, _eventId);
    expect(listEarthquake.estimatedIntensityTile, _legacyUrl);
    expect(detailEarthquake.estimatedIntensityTile, _legacyUrl);
    expect(listArchive, isNotNull);
    expect(detailArchive, isNotNull);
    if (listArchive == null || detailArchive == null) {
      fail('推計震度archive descriptorが復元されなかった');
    }

    expect(listArchive.url, detailArchive.url);
    expect(listArchive.sizeBytes, detailArchive.sizeBytes);
    expect(listArchive.sha256, detailArchive.sha256);
    expect(listArchive.sizeBytes, _sizeBytes);
    expect(listArchive.sha256, _sha256);
    expect(listArchive.sha256, matches(RegExp(r'^[0-9a-f]{64}$')));

    final pathSegments = Uri.parse(listArchive.url).pathSegments;
    expect(pathSegments, hasLength(3));
    expect(pathSegments[0], 'ixac41');
    expect(pathSegments[1], _eventId);
    expect(pathSegments[2], '$_sha256.pmtiles');
  });
}
