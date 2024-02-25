import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Earthquake History List Tile',
  type: EarthquakeHistoryListTile,
)
Widget earthquakeHistoryListTile(BuildContext context) {
  return Scaffold(
    body: EarthquakeHistoryListTile(
      item: EarthquakeV1Extended(
        earthquake: context.knobs.earthquakeV1(label: 'Earthquake V1'),
        maxIntensityRegionNames: [],
      ),
      onTap: () {},
    ),
  );
}

class EarthquakeV1Knob extends Knob<EarthquakeV1> {
  EarthquakeV1Knob({
    required super.label,
    required super.initialValue,
  });

  @override
  List<Field> get fields => [
        IntInputField(
          name: 'event_id',
          initialValue: 20211020123456,
        ),
        StringField(
          name: 'status',
          initialValue: '通常',
        ),
        DoubleInputField(
          name: 'latitude',
          initialValue: 35,
        ),
        DoubleInputField(
          name: 'longitude',
          initialValue: 135,
        ),
        IntInputField(
          name: 'epicenter_code',
          initialValue: 101,
        ),
        DateTimeField(
          name: 'arrival_time',
          start: DateTime(2000),
          end: DateTime(2100),
          initialValue: DateTime.now(),
        ),
        DateTimeField(
          name: 'origin_time',
          start: DateTime(2000),
          end: DateTime(2100),
          initialValue: DateTime.now(),
        ),
        DoubleInputField(
          name: 'magnitude',
          initialValue: null,
        ),
        IntInputField(
          name: 'depth',
          initialValue: null,
        ),
        ListField<JmaIntensity>(
          name: 'max_intensity',
          values: JmaIntensity.values,
          initialValue: JmaIntensity.fiveLower,
          labelBuilder: (value) => value.type,
        ),
        ListField<JmaLgIntensity>(
          name: 'max_lpgm_intensity',
          values: JmaLgIntensity.values,
          initialValue: JmaLgIntensity.zero,
          labelBuilder: (value) => value.type,
        ),
      ];

  @override
  EarthquakeV1 valueFromQueryGroup(Map<String, String> group) => EarthquakeV1(
        eventId: valueOf('event_id', group)!,
        status: valueOf('status', group)!,
        latitude: valueOf('latitude', group),
        longitude: valueOf('longitude', group),
        arrivalTime: valueOf('arrival_time', group),
        originTime: valueOf('origin_time', group),
        depth: valueOf('depth', group),
        epicenterCode: valueOf('epicenter_code', group),
        intensityCities: [],
        intensityPrefectures: [],
        intensityRegions: [],
        intensityStations: [],
        magnitude: valueOf('magnitude', group),
        maxIntensity: valueOf('max_intensity', group),
        maxLpgmIntensity: valueOf('max_lpgm_intensity', group),
      );
}

extension EarthquakeV1KnobBuilder on KnobsBuilder {
  EarthquakeV1 earthquakeV1({
    required String label,
    EarthquakeV1 initialValue = const EarthquakeV1(
      eventId: 20211020123456,
      status: '通常',
      latitude: 35,
      longitude: 135,
      depth: 10,
      epicenterCode: 101,
      intensityCities: [],
      intensityPrefectures: [],
      intensityRegions: [],
      intensityStations: [],
      magnitude: 5,
      maxIntensity: JmaIntensity.fiveLower,
    ),
  }) =>
      onKnobAdded(
        EarthquakeV1Knob(
          label: label,
          initialValue: initialValue,
        ),
      )!;
}
