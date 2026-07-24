import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_reducer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const reducer = EarthquakeVxseDebugReducer();
  const factory = EarthquakeVxseDebugDraftFactory();
  final draftSource = _draftSource();

  group('EarthquakeVxseDebugReducer', () {
    test('VXSE51-onlyへVXSE52をmergeしても最大震度を保持する', () {
      final current = _current().copyWith(
        telegramTypes: const [
          EarthquakeTelegramType.vxse51,
          EarthquakeTelegramType.vxse51,
        ],
      );
      final draft = factory.create(
        current: draftSource,
        type: EarthquakeTelegramType.vxse52,
      );

      final result = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.merge,
      );

      expect(result.intensity?.maxIntensity, JmaIntensity.fiveLower);
      expect(result.hypocenter, earthquakeVxseDebugSampleHypocenter);
      expect(result.telegramTypes, [
        EarthquakeTelegramType.vxse51,
        EarthquakeTelegramType.vxse52,
      ]);
    });

    for (final mode in EarthquakeVxseApplyMode.values) {
      for (final type in _supportedTypes) {
        test('${type.name}を${mode.name}で全owned fieldsへ適用する', () {
          final current = _current();
          final draft = factory.create(current: draftSource, type: type);

          final result = reducer.apply(
            current: current,
            draft: draft,
            mode: mode,
          );

          expect(result.status, TelegramStatus.training);
          expect(result.telegramTypes.where((item) => item == type), [type]);
          expect(result.eventId, current.eventId);
          expect(result.dataSources, current.dataSources);
          expect(result.originTimePrecision, current.originTimePrecision);
          expect(
            result.estimatedIntensityTileUrl,
            current.estimatedIntensityTileUrl,
          );
          expect(
            result.telegramComments,
            contains(
              _comment(
                type: type,
                reportedAt: earthquakeVxseDebugSampleReportedAt,
                text: type.name,
              ),
            ),
          );
          _expectOwnedFieldsApplied(
            result: result,
            current: current,
            type: type,
          );
        });
      }
    }

    test('mergeは同じtype/reportedAtのコメントだけをupsertする', () {
      final reportedAt = DateTime.utc(2026, 7, 24, 3);
      final current = _current().copyWith(
        telegramComments: [
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: reportedAt,
            text: 'old',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: DateTime.utc(2026, 7, 24, 2),
            text: 'older',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse52,
            reportedAt: reportedAt,
            text: 'outside',
          ),
        ],
      );
      final draft = EarthquakeVxseDebugDraft.vxse51(
        eventId: current.eventId,
        reportedAt: reportedAt,
        status: TelegramStatus.normal,
        maxIntensity: JmaIntensity.four,
        regions: const {},
        prefectures: const {},
        comments: [
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: reportedAt,
            text: 'new',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: reportedAt,
            text: 'newest',
          ),
        ],
      );

      final result = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.merge,
      );

      expect(result.telegramComments, [
        _comment(
          type: EarthquakeTelegramType.vxse51,
          reportedAt: DateTime.utc(2026, 7, 24, 2),
          text: 'older',
        ),
        _comment(
          type: EarthquakeTelegramType.vxse52,
          reportedAt: reportedAt,
          text: 'outside',
        ),
        _comment(
          type: EarthquakeTelegramType.vxse51,
          reportedAt: reportedAt,
          text: 'newest',
        ),
      ]);
    });

    test('clearAndApplyは選択typeの旧コメントだけをclearしてから適用する', () {
      final current = _current().copyWith(
        telegramComments: [
          _comment(
            type: EarthquakeTelegramType.vxse62,
            reportedAt: DateTime.utc(2026, 7, 24, 1),
            text: 'old-1',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse62,
            reportedAt: DateTime.utc(2026, 7, 24, 2),
            text: 'old-2',
          ),
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: DateTime.utc(2026, 7, 24, 1),
            text: 'outside',
          ),
        ],
      );
      final draft = factory.create(
        current: draftSource,
        type: EarthquakeTelegramType.vxse62,
      );

      final result = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.clearAndApply,
      );

      expect(
        result.telegramComments.where(
          (comment) => comment.type == EarthquakeTelegramType.vxse62,
        ),
        draft.comments,
      );
      expect(
        result.telegramComments.where(
          (comment) => comment.type == EarthquakeTelegramType.vxse51,
        ),
        [
          _comment(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: DateTime.utc(2026, 7, 24, 1),
            text: 'outside',
          ),
        ],
      );
    });

    for (final mode in EarthquakeVxseApplyMode.values) {
      test('${mode.name}は選択typeのtelegram metadataだけをdraft.reportedAtで更新する', () {
        final current = _current().copyWith(
          telegramMetadata: [
            EarthquakeTelegramMetadata(
              type: EarthquakeTelegramType.vxse51,
              reportedAt: DateTime.utc(2026, 7, 24, 1),
            ),
            EarthquakeTelegramMetadata(
              type: EarthquakeTelegramType.vxse52,
              reportedAt: DateTime.utc(2026, 7, 24, 2),
            ),
          ],
        );
        final draft = EarthquakeVxseDebugDraft.vxse51(
          eventId: current.eventId,
          reportedAt: DateTime.utc(2026, 7, 24, 9),
          status: TelegramStatus.normal,
          maxIntensity: JmaIntensity.four,
          regions: const {},
          prefectures: const {},
          comments: const [],
        );

        final result = reducer.apply(
          current: current,
          draft: draft,
          mode: mode,
        );

        expect(result.telegramMetadata, [
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse52,
            reportedAt: DateTime.utc(2026, 7, 24, 2),
          ),
          EarthquakeTelegramMetadata(
            type: EarthquakeTelegramType.vxse51,
            reportedAt: DateTime.utc(2026, 7, 24, 9),
          ),
        ]);
      });
    }

    test('VXSE51適用は非ownedのcity/stationとLPGMを保持する', () {
      final current = _current();
      final result = reducer.apply(
        current: current,
        draft: factory.create(
          current: draftSource,
          type: EarthquakeTelegramType.vxse51,
        ),
        mode: EarthquakeVxseApplyMode.clearAndApply,
      );

      final city =
          result.intensity?.intensityTree.values.single.single.cities.single;
      expect(
        city,
        current.intensity?.intensityTree.values.single.single.cities.single,
      );
      expect(
        result.intensity?.maxLpgmIntensity,
        current.intensity?.maxLpgmIntensity,
      );
      expect(
        result.intensity?.lpgmIntensityTree,
        current.intensity?.lpgmIntensityTree,
      );
    });

    test('VXSE62適用は非ownedの通常・LPGM city fieldsを保持する', () {
      final current = _current();
      final result = reducer.apply(
        current: current,
        draft: factory.create(
          current: draftSource,
          type: EarthquakeTelegramType.vxse62,
        ),
        mode: EarthquakeVxseApplyMode.clearAndApply,
      );

      final currentIntensity = current.intensity;
      final resultIntensity = result.intensity;
      expect(
        resultIntensity
            ?.intensityTree
            .values
            .single
            .single
            .cities
            .single
            .maxIntensity,
        currentIntensity
            ?.intensityTree
            .values
            .single
            .single
            .cities
            .single
            .maxIntensity,
      );
      expect(
        resultIntensity
            ?.lpgmIntensityTree
            .values
            .single
            .single
            .cities
            .single
            .maxLpgmIntensity,
        currentIntensity
            ?.lpgmIntensityTree
            .values
            .single
            .single
            .cities
            .single
            .maxLpgmIntensity,
      );
    });

    test('VXSE51 mergeはcode単位でupsertしclearAndApplyだけがowned entryを消す', () {
      final current = _earthquakeWithSecondTopology();
      final draft = EarthquakeVxseDebugDraft.vxse51(
        eventId: current.eventId,
        reportedAt: earthquakeVxseDebugSampleReportedAt,
        status: TelegramStatus.normal,
        maxIntensity: JmaIntensity.three,
        regions: {
          JmaIntensity.three: [
            earthquakeVxseDebugSampleIntensityRegion.copyWith(
              maxIntensity: JmaIntensity.three,
            ),
          ],
        },
        prefectures: {
          JmaIntensity.three: [
            earthquakeVxseDebugSampleIntensityPrefecture.copyWith(
              maxIntensity: JmaIntensity.three,
            ),
          ],
        },
        comments: const [],
      );

      final merged = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.merge,
      );
      final cleared = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.clearAndApply,
      );

      expect(_regionCodes(merged), containsAll(['350', '351']));
      expect(_prefectureCodes(merged), containsAll(['13', '14']));
      expect(_cityCodes(merged), containsAll(['1310100', '1410000']));
      expect(_regionCodes(cleared), ['350']);
      expect(_prefectureMax(cleared, '14'), isNull);
      expect(_cityCodes(cleared), containsAll(['1310100', '1410000']));
    });

    test('VXSE53 mergeはpartial collectionをupsertしclearAndApplyは置換する', () {
      final current = _earthquakeWithSecondTopology();
      final draft = factory.create(
        current: _draftSource(),
        type: EarthquakeTelegramType.vxse53,
      );

      final merged = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.merge,
      );
      final cleared = reducer.apply(
        current: current,
        draft: draft,
        mode: EarthquakeVxseApplyMode.clearAndApply,
      );

      expect(_regionCodes(merged), containsAll(['350', '351']));
      expect(_prefectureCodes(merged), containsAll(['13', '14']));
      expect(_cityCodes(merged), containsAll(['1310100', '1410000']));
      expect(_regionCodes(cleared), ['350']);
      expect(_prefectureCodes(cleared), ['13']);
      expect(_cityCodes(cleared), ['1310100']);
    });

    test('VXSE62はdraft topologyが異なっても非owned cityを保持してstationをupsertする', () {
      final current = _earthquakeWithSecondTopology();
      final changedCity = earthquakeVxseDebugSampleCity.copyWith(
        code: 'changed-city',
      );
      final updatedStationIntensity = earthquakeVxseDebugSampleStationIntensity
          .copyWith(name: 'updated');
      final draft = EarthquakeVxseDebugDraft.vxse62(
        eventId: current.eventId,
        reportedAt: earthquakeVxseDebugSampleReportedAt,
        status: TelegramStatus.normal,
        arrivalTime: current.arrivalTime,
        originTime: current.originTime,
        hypocenter: earthquakeVxseDebugSampleHypocenter,
        maxIntensity: JmaIntensity.four,
        maxLpgmIntensity: JmaLpgmIntensity.two,
        regions: _draftIntensity.regions,
        intensityTree: {
          JmaIntensity.four: [
            PrefectureIntensityNode(
              prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
              cities: [
                CityIntensityNode(
                  city: changedCity,
                  maxIntensity: JmaIntensity.one,
                  stations: [
                    StationIntensityNode(
                      station: earthquakeVxseDebugSampleStation,
                      intensity: updatedStationIntensity,
                    ),
                  ],
                ),
              ],
            ),
          ],
        },
        lpgmRegions: const {
          JmaLpgmIntensity.two: [earthquakeVxseDebugSampleLpgmRegion],
        },
        lpgmIntensityTree: {
          JmaLpgmIntensity.two: [
            PrefectureLpgmIntensityNode(
              region: earthquakeVxseDebugSampleRegion,
              maxLpgmIntensity: JmaLpgmIntensity.two,
              cities: [
                CityLpgmIntensityNode(
                  city: changedCity,
                  maxLpgmIntensity: JmaLpgmIntensity.one,
                  stations: [
                    StationLpgmIntensityNode(
                      station: earthquakeVxseDebugSampleStation,
                      intensity: updatedStationIntensity,
                    ),
                  ],
                ),
              ],
            ),
          ],
        },
        comments: const [],
      );

      for (final mode in EarthquakeVxseApplyMode.values) {
        final result = reducer.apply(
          current: current,
          draft: draft,
          mode: mode,
        );

        expect(_cityCodes(result), containsAll(['1310100', '1410000']));
        expect(_lpgmCityCodes(result), containsAll(['1310100', '1410000']));
        expect(_stationName(result, '1310100'), 'updated');
        expect(_lpgmStationName(result, '1310100'), 'updated');
      }
    });

    for (final mode in EarthquakeVxseApplyMode.values) {
      test('${mode.name}のVXSE62は既存cityへdraft-only stationを通常・LPGM双方で追加する', () {
        final current = _current();
        final newStation = earthquakeVxseDebugSampleStation.copyWith(
          code: 'new-station',
          noCode: 'new-no-code',
        );
        final newIntensity = earthquakeVxseDebugSampleStationIntensity.copyWith(
          code: 'new-station',
          name: 'new-station',
        );
        final draft = _vxse62DraftWithTrees(
          current: current,
          ordinaryTree: {
            JmaIntensity.four: [
              PrefectureIntensityNode(
                prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
                cities: [
                  CityIntensityNode(
                    city: earthquakeVxseDebugSampleCity,
                    maxIntensity: JmaIntensity.one,
                    stations: [
                      StationIntensityNode(
                        station: newStation,
                        intensity: newIntensity,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          },
          lpgmTree: {
            JmaLpgmIntensity.two: [
              PrefectureLpgmIntensityNode(
                region: earthquakeVxseDebugSampleRegion,
                maxLpgmIntensity: JmaLpgmIntensity.two,
                cities: [
                  CityLpgmIntensityNode(
                    city: earthquakeVxseDebugSampleCity,
                    maxLpgmIntensity: JmaLpgmIntensity.one,
                    stations: [
                      StationLpgmIntensityNode(
                        station: newStation,
                        intensity: newIntensity,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          },
        );

        final result = reducer.apply(
          current: current,
          draft: draft,
          mode: mode,
        );

        expect(_stationCodes(result, '1310100'), contains('new-station'));
        expect(_lpgmStationCodes(result, '1310100'), contains('new-station'));
        expect(_stationNameByCode(result, 'new-station'), 'new-station');
        expect(_lpgmStationNameByCode(result, 'new-station'), 'new-station');
      });

      test('${mode.name}のVXSE62はdraftが明示した新規city topologyへstationを追加する', () {
        final current = _current();
        final newStation = earthquakeVxseDebugSampleStation.copyWith(
          code: 'new-city-station',
          noCode: 'new-city-no-code',
        );
        final newCity = earthquakeVxseDebugSampleCity.copyWith(
          code: 'new-city',
          stations: [newStation],
        );
        final newIntensity = earthquakeVxseDebugSampleStationIntensity.copyWith(
          code: 'new-city-station',
          name: 'new-city-station',
        );
        final draft = _vxse62DraftWithTrees(
          current: current,
          ordinaryTree: {
            JmaIntensity.four: [
              PrefectureIntensityNode(
                prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
                cities: [
                  CityIntensityNode(
                    city: newCity,
                    maxIntensity: JmaIntensity.one,
                    stations: [
                      StationIntensityNode(
                        station: newStation,
                        intensity: newIntensity,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          },
          lpgmTree: {
            JmaLpgmIntensity.two: [
              PrefectureLpgmIntensityNode(
                region: earthquakeVxseDebugSampleRegion,
                maxLpgmIntensity: JmaLpgmIntensity.two,
                cities: [
                  CityLpgmIntensityNode(
                    city: newCity,
                    maxLpgmIntensity: JmaLpgmIntensity.one,
                    stations: [
                      StationLpgmIntensityNode(
                        station: newStation,
                        intensity: newIntensity,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          },
        );

        final result = reducer.apply(
          current: current,
          draft: draft,
          mode: mode,
        );

        expect(_cityCodes(result), contains('new-city'));
        expect(_lpgmCityCodes(result), contains('new-city'));
        expect(_stationCodes(result, 'new-city'), ['new-city-station']);
        expect(_lpgmStationCodes(result, 'new-city'), ['new-city-station']);
        expect(_ordinaryCity(result, 'new-city')?.maxIntensity, isNull);
        expect(_ordinaryCity(result, 'new-city')?.maxLpgmIntensity, isNull);
        expect(_lpgmCity(result, 'new-city')?.maxLpgmIntensity, isNull);
      });

      test('${mode.name}のVXSE62はtree更新なしのlpgmRegionsをcode単位でupsertする', () {
        final current = _current();
        final newRegion = earthquakeVxseDebugSampleRegion.copyWith(
          code: 'new-lpgm-region',
        );
        final draft = _vxse62DraftWithTrees(
          current: current,
          ordinaryTree: const {},
          lpgmRegions: {
            JmaLpgmIntensity.one: [
              earthquakeVxseDebugSampleLpgmRegion.copyWith(
                maxLpgmIntensity: JmaLpgmIntensity.one,
              ),
              LpgmIntensityRegion(
                region: newRegion,
                maxLpgmIntensity: JmaLpgmIntensity.one,
              ),
            ],
          },
          lpgmTree: const {},
        );

        final result = reducer.apply(
          current: current,
          draft: draft,
          mode: mode,
        );

        expect(_lpgmRegionMax(result, '350'), JmaLpgmIntensity.one);
        expect(_lpgmRegionMax(result, 'new-lpgm-region'), JmaLpgmIntensity.one);
      });

      test('${mode.name}のVXSE62は新規stationのdraft親cityが競合する場合にrejectする', () {
        final current = _current();
        final station = earthquakeVxseDebugSampleStation.copyWith(
          code: 'ambiguous-station',
          noCode: 'ambiguous-no-code',
        );
        final otherCity = earthquakeVxseDebugSampleCity.copyWith(
          code: 'other-city',
          stations: [station],
        );
        final stationIntensity = earthquakeVxseDebugSampleStationIntensity
            .copyWith(code: 'ambiguous-station');
        final draft = _vxse62DraftWithTrees(
          current: current,
          ordinaryTree: {
            JmaIntensity.four: [
              PrefectureIntensityNode(
                prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
                cities: [
                  CityIntensityNode(
                    city: earthquakeVxseDebugSampleCity,
                    maxIntensity: JmaIntensity.one,
                    stations: [
                      StationIntensityNode(
                        station: station,
                        intensity: stationIntensity,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          },
          lpgmTree: {
            JmaLpgmIntensity.two: [
              PrefectureLpgmIntensityNode(
                region: earthquakeVxseDebugSampleRegion,
                maxLpgmIntensity: JmaLpgmIntensity.two,
                cities: [
                  CityLpgmIntensityNode(
                    city: otherCity,
                    maxLpgmIntensity: JmaLpgmIntensity.one,
                    stations: [
                      StationLpgmIntensityNode(
                        station: station,
                        intensity: stationIntensity,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          },
        );

        expect(
          () => reducer.apply(current: current, draft: draft, mode: mode),
          throwsA(
            isA<EarthquakeVxseDebugDraftValidationException>().having(
              (error) => error.issues.length,
              'issues.length',
              1,
            ),
          ),
        );
      });
    }

    for (final mode in EarthquakeVxseApplyMode.values) {
      test('${mode.name}はdraft variant外のcommentを明示的にrejectする', () {
        final current = _current().copyWith(
          telegramComments: [
            _comment(
              type: EarthquakeTelegramType.vxse53,
              reportedAt: earthquakeVxseDebugSampleReportedAt,
              text: 'preserved',
            ),
          ],
        );
        final draft = EarthquakeVxseDebugDraft.vxse51(
          eventId: current.eventId,
          reportedAt: earthquakeVxseDebugSampleReportedAt,
          status: TelegramStatus.normal,
          maxIntensity: JmaIntensity.four,
          regions: const {},
          prefectures: const {},
          comments: [
            _comment(
              type: EarthquakeTelegramType.vxse53,
              reportedAt: earthquakeVxseDebugSampleReportedAt,
              text: 'colliding-cross-type',
            ),
            _comment(
              type: EarthquakeTelegramType.vxse53,
              reportedAt: DateTime.utc(2026, 7, 24, 12),
              text: 'non-colliding-cross-type',
            ),
          ],
        );

        expect(
          () => reducer.apply(current: current, draft: draft, mode: mode),
          throwsA(
            isA<EarthquakeVxseDebugDraftValidationException>().having(
              (error) => error.issues.length,
              'issues.length',
              2,
            ),
          ),
        );
        expect(current.telegramComments.single.additional, 'preserved');
      });
    }
  });
}

void _expectOwnedFieldsApplied({
  required Earthquake result,
  required Earthquake current,
  required EarthquakeTelegramType type,
}) {
  switch (type) {
    case .vxse51:
      expect(result.intensity?.maxIntensity, JmaIntensity.four);
      expect(result.intensity?.regions, _draftIntensity.regions);
      expect(
        result.intensity?.intensityTree.values.single.single.prefecture,
        _draftIntensity.intensityTree.values.single.single.prefecture,
      );
      expect(result.hypocenter, current.hypocenter);
      expect(result.originTime, current.originTime);
      expect(result.earthquakeType, current.earthquakeType);
    case .vxse52 || .vxse61:
      expect(result.hypocenter, earthquakeVxseDebugSampleHypocenter);
      expect(result.originTime, earthquakeVxseDebugSampleOriginTime);
      expect(result.arrivalTime, earthquakeVxseDebugSampleArrivalTime);
      expect(result.intensity, current.intensity);
      expect(result.earthquakeType, current.earthquakeType);
    case .vxse53:
      expect(result.hypocenter, earthquakeVxseDebugSampleHypocenter);
      expect(result.originTime, earthquakeVxseDebugSampleOriginTime);
      expect(result.arrivalTime, earthquakeVxseDebugSampleArrivalTime);
      expect(result.intensity?.maxIntensity, JmaIntensity.four);
      expect(result.intensity?.regions, _draftIntensity.regions);
      expect(result.intensity?.intensityTree, _draftIntensity.intensityTree);
      expect(
        result.intensity?.maxLpgmIntensity,
        current.intensity?.maxLpgmIntensity,
      );
      expect(
        result.intensity?.lpgmIntensityTree,
        current.intensity?.lpgmIntensityTree,
      );
      expect(result.earthquakeType, EarthquakeType.distant);
    case .vxse62:
      expect(result.hypocenter, earthquakeVxseDebugSampleHypocenter);
      expect(result.originTime, earthquakeVxseDebugSampleOriginTime);
      expect(result.arrivalTime, earthquakeVxseDebugSampleArrivalTime);
      expect(result.intensity?.maxIntensity, JmaIntensity.four);
      expect(result.intensity?.regions, _draftIntensity.regions);
      expect(
        result.intensity?.intensityTree.values.single.single.prefecture,
        _draftIntensity.intensityTree.values.single.single.prefecture,
      );
      expect(
        result
            .intensity
            ?.intensityTree
            .values
            .single
            .single
            .cities
            .single
            .stations,
        _draftIntensity
            .intensityTree
            .values
            .single
            .single
            .cities
            .single
            .stations,
      );
      expect(result.earthquakeType, current.earthquakeType);
      expect(result.intensity?.maxLpgmIntensity, JmaLpgmIntensity.two);
      expect(
        result
            .intensity
            ?.lpgmIntensityTree
            .values
            .single
            .single
            .maxLpgmIntensity,
        JmaLpgmIntensity.two,
      );
      expect(
        result
            .intensity
            ?.lpgmIntensityTree
            .values
            .single
            .single
            .cities
            .single
            .stations,
        _draftIntensity
            .lpgmIntensityTree
            .values
            .single
            .single
            .cities
            .single
            .stations,
      );
    case .vxse45Forecast || .vxse45Warning:
      throw ArgumentError.value(type, 'type', 'VXSE51/52/53/61/62 only');
  }
}

EarthquakeTelegramComment _comment({
  required EarthquakeTelegramType type,
  required DateTime reportedAt,
  required String text,
}) => EarthquakeTelegramComment(
  type: type,
  reportedAt: reportedAt,
  additional: text,
  free: null,
);

EarthquakeVxseDebugDraft _vxse62DraftWithTrees({
  required Earthquake current,
  required Map<JmaIntensity, List<PrefectureIntensityNode>> ordinaryTree,
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmTree,
  Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> lpgmRegions = const {},
}) => EarthquakeVxseDebugDraft.vxse62(
  eventId: current.eventId,
  reportedAt: earthquakeVxseDebugSampleReportedAt,
  status: TelegramStatus.normal,
  arrivalTime: current.arrivalTime,
  originTime: current.originTime,
  hypocenter: earthquakeVxseDebugSampleHypocenter,
  maxIntensity: JmaIntensity.four,
  maxLpgmIntensity: JmaLpgmIntensity.two,
  regions: const {},
  intensityTree: ordinaryTree,
  lpgmRegions: lpgmRegions,
  lpgmIntensityTree: lpgmTree,
  comments: const [],
);

const _supportedTypes = [
  EarthquakeTelegramType.vxse51,
  EarthquakeTelegramType.vxse52,
  EarthquakeTelegramType.vxse53,
  EarthquakeTelegramType.vxse61,
  EarthquakeTelegramType.vxse62,
];

const _baseIntensity = EarthquakeIntensity(
  maxIntensity: JmaIntensity.fiveLower,
  maxLpgmIntensity: JmaLpgmIntensity.three,
  regions: {
    JmaIntensity.fiveLower: [
      IntensityRegion(
        region: earthquakeVxseDebugSampleRegion,
        maxIntensity: JmaIntensity.fiveLower,
      ),
    ],
  },
  intensityTree: {
    JmaIntensity.fiveLower: [
      PrefectureIntensityNode(
        prefecture: IntensityPrefecture(
          prefecture: earthquakeVxseDebugSamplePrefecture,
          maxIntensity: JmaIntensity.fiveLower,
        ),
        cities: [
          CityIntensityNode(
            city: earthquakeVxseDebugSampleCity,
            maxIntensity: JmaIntensity.fiveLower,
            stations: [
              StationIntensityNode(
                station: earthquakeVxseDebugSampleStation,
                intensity: earthquakeVxseDebugSampleStationIntensity,
              ),
            ],
            maxLpgmIntensity: JmaLpgmIntensity.three,
          ),
        ],
      ),
    ],
  },
  lpgmIntensityTree: {
    JmaLpgmIntensity.three: [
      PrefectureLpgmIntensityNode(
        region: earthquakeVxseDebugSampleRegion,
        maxLpgmIntensity: JmaLpgmIntensity.three,
        cities: [
          CityLpgmIntensityNode(
            city: earthquakeVxseDebugSampleCity,
            maxLpgmIntensity: JmaLpgmIntensity.three,
            stations: [
              StationLpgmIntensityNode(
                station: earthquakeVxseDebugSampleStation,
                intensity: earthquakeVxseDebugSampleStationIntensity,
              ),
            ],
          ),
        ],
      ),
    ],
  },
);

const _draftIntensity = EarthquakeIntensity(
  maxIntensity: JmaIntensity.four,
  maxLpgmIntensity: JmaLpgmIntensity.two,
  regions: {
    JmaIntensity.four: [earthquakeVxseDebugSampleIntensityRegion],
  },
  intensityTree: {
    JmaIntensity.four: [
      PrefectureIntensityNode(
        prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
        cities: [
          CityIntensityNode(
            city: earthquakeVxseDebugSampleCity,
            maxIntensity: JmaIntensity.four,
            stations: [
              StationIntensityNode(
                station: earthquakeVxseDebugSampleStation,
                intensity: earthquakeVxseDebugSampleStationIntensity,
              ),
            ],
            maxLpgmIntensity: JmaLpgmIntensity.two,
          ),
        ],
      ),
    ],
  },
  lpgmIntensityTree: {
    JmaLpgmIntensity.two: [
      PrefectureLpgmIntensityNode(
        region: earthquakeVxseDebugSampleRegion,
        maxLpgmIntensity: JmaLpgmIntensity.two,
        cities: [
          CityLpgmIntensityNode(
            city: earthquakeVxseDebugSampleCity,
            maxLpgmIntensity: JmaLpgmIntensity.two,
            stations: [
              StationLpgmIntensityNode(
                station: earthquakeVxseDebugSampleStation,
                intensity: earthquakeVxseDebugSampleStationIntensity,
              ),
            ],
          ),
        ],
      ),
    ],
  },
);

Earthquake _current() => Earthquake(
  eventId: 'event-id',
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 7, 24, 1),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: DateTime.utc(2026, 7, 24, 1, 1),
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [EarthquakeTelegramType.vxse51],
  hypocenter: earthquakeVxseDebugSampleHypocenter.copyWith(name: 'current'),
  intensity: _baseIntensity,
  earthquakeType: EarthquakeType.volcano,
  estimatedIntensityTileUrl: 'https://example.com/current.pmtiles',
);

Earthquake _draftSource() => Earthquake(
  eventId: 'event-id',
  status: TelegramStatus.training,
  originTime: earthquakeVxseDebugSampleOriginTime,
  originTimePrecision: OriginTimePrecision.minute,
  arrivalTime: earthquakeVxseDebugSampleArrivalTime,
  dataSources: const [],
  telegramTypes: _supportedTypes,
  telegramComments: [
    for (final type in _supportedTypes)
      _comment(
        type: type,
        reportedAt: earthquakeVxseDebugSampleReportedAt,
        text: type.name,
      ),
  ],
  hypocenter: earthquakeVxseDebugSampleHypocenter,
  intensity: _draftIntensity,
  earthquakeType: EarthquakeType.distant,
  estimatedIntensityTileUrl: null,
);

Earthquake _earthquakeWithSecondTopology() {
  final secondStation = earthquakeVxseDebugSampleStation.copyWith(
    code: '1410000',
    noCode: '3510000',
  );
  final secondCity = earthquakeVxseDebugSampleCity.copyWith(
    code: '1410000',
    stations: [secondStation],
  );
  final secondRegion = earthquakeVxseDebugSampleRegion.copyWith(
    code: '351',
    cities: [secondCity],
  );
  final secondPrefecture = earthquakeVxseDebugSamplePrefecture.copyWith(
    code: '14',
    regions: [secondRegion],
  );
  final secondIntensity = earthquakeVxseDebugSampleStationIntensity.copyWith(
    code: '1410000',
    name: 'second',
  );
  return _current().copyWith(
    intensity: _baseIntensity.copyWith(
      regions: {
        ..._baseIntensity.regions,
        JmaIntensity.four: [
          IntensityRegion(
            region: secondRegion,
            maxIntensity: JmaIntensity.four,
          ),
        ],
      },
      intensityTree: {
        ..._baseIntensity.intensityTree,
        JmaIntensity.four: [
          PrefectureIntensityNode(
            prefecture: IntensityPrefecture(
              prefecture: secondPrefecture,
              maxIntensity: JmaIntensity.four,
            ),
            cities: [
              CityIntensityNode(
                city: secondCity,
                maxIntensity: JmaIntensity.four,
                stations: [
                  StationIntensityNode(
                    station: secondStation,
                    intensity: secondIntensity,
                  ),
                ],
              ),
            ],
          ),
        ],
      },
      lpgmIntensityTree: {
        ..._baseIntensity.lpgmIntensityTree,
        JmaLpgmIntensity.two: [
          PrefectureLpgmIntensityNode(
            region: secondRegion,
            maxLpgmIntensity: JmaLpgmIntensity.two,
            cities: [
              CityLpgmIntensityNode(
                city: secondCity,
                maxLpgmIntensity: JmaLpgmIntensity.two,
                stations: [
                  StationLpgmIntensityNode(
                    station: secondStation,
                    intensity: secondIntensity,
                  ),
                ],
              ),
            ],
          ),
        ],
      },
    ),
  );
}

List<String> _regionCodes(Earthquake earthquake) =>
    earthquake.intensity?.regions.values
        .expand((items) => items)
        .map((item) => item.region.code)
        .toList() ??
    const [];

List<String> _prefectureCodes(Earthquake earthquake) =>
    earthquake.intensity?.intensityTree.values
        .expand((items) => items)
        .map((item) => item.prefecture.prefecture.code)
        .toList() ??
    const [];

List<String> _cityCodes(Earthquake earthquake) =>
    earthquake.intensity?.intensityTree.values
        .expand((items) => items)
        .expand((item) => item.cities)
        .map((item) => item.city.code)
        .toList() ??
    const [];

List<String> _lpgmCityCodes(Earthquake earthquake) =>
    earthquake.intensity?.lpgmIntensityTree.values
        .expand((items) => items)
        .expand((item) => item.cities)
        .map((item) => item.city.code)
        .toList() ??
    const [];

JmaIntensity? _prefectureMax(Earthquake earthquake, String code) => earthquake
    .intensity
    ?.intensityTree
    .values
    .expand((items) => items)
    .firstWhere((item) => item.prefecture.prefecture.code == code)
    .prefecture
    .maxIntensity;

String? _stationName(Earthquake earthquake, String code) => earthquake
    .intensity
    ?.intensityTree
    .values
    .expand((items) => items)
    .expand((item) => item.cities)
    .expand((item) => item.stations)
    .firstWhere((item) => item.station.code == code)
    .intensity
    ?.name;

String? _lpgmStationName(Earthquake earthquake, String code) => earthquake
    .intensity
    ?.lpgmIntensityTree
    .values
    .expand((items) => items)
    .expand((item) => item.cities)
    .expand((item) => item.stations)
    .firstWhere((item) => item.station.code == code)
    .intensity
    ?.name;

List<String> _stationCodes(Earthquake earthquake, String cityCode) =>
    earthquake.intensity?.intensityTree.values
        .expand((items) => items)
        .expand((item) => item.cities)
        .firstWhere((item) => item.city.code == cityCode)
        .stations
        .map((item) => item.station.code)
        .toList() ??
    const [];

List<String> _lpgmStationCodes(Earthquake earthquake, String cityCode) =>
    earthquake.intensity?.lpgmIntensityTree.values
        .expand((items) => items)
        .expand((item) => item.cities)
        .firstWhere((item) => item.city.code == cityCode)
        .stations
        .map((item) => item.station.code)
        .toList() ??
    const [];

String? _stationNameByCode(Earthquake earthquake, String stationCode) =>
    earthquake.intensity?.intensityTree.values
        .expand((items) => items)
        .expand((item) => item.cities)
        .expand((item) => item.stations)
        .firstWhere((item) => item.station.code == stationCode)
        .intensity
        ?.name;

String? _lpgmStationNameByCode(Earthquake earthquake, String stationCode) =>
    earthquake.intensity?.lpgmIntensityTree.values
        .expand((items) => items)
        .expand((item) => item.cities)
        .expand((item) => item.stations)
        .firstWhere((item) => item.station.code == stationCode)
        .intensity
        ?.name;

JmaLpgmIntensity? _lpgmRegionMax(Earthquake earthquake, String regionCode) =>
    earthquake.intensity?.lpgmIntensityTree.values
        .expand((items) => items)
        .firstWhere((item) => item.region.code == regionCode)
        .maxLpgmIntensity;

CityIntensityNode? _ordinaryCity(Earthquake earthquake, String cityCode) =>
    earthquake.intensity?.intensityTree.values
        .expand((items) => items)
        .expand((item) => item.cities)
        .firstWhere((item) => item.city.code == cityCode);

CityLpgmIntensityNode? _lpgmCity(Earthquake earthquake, String cityCode) =>
    earthquake.intensity?.lpgmIntensityTree.values
        .expand((items) => items)
        .expand((item) => item.cities)
        .firstWhere((item) => item.city.code == cityCode);
