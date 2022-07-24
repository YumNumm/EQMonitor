import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/model/earthquake/earthquake_item.dart';
import 'package:eqmonitor/model/earthquake/earthquake_log_model.dart';
import 'package:eqmonitor/schema/dmdata/websocketv2/type.dart';
import 'package:eqmonitor/schema/supabase/telegram.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

/// ref: https://github.com/ingen084/KyoshinEewViewerIngen/blob/2801ad7959f99abe7ac81c2ff3a7d1974716a786/src/KyoshinEewViewer/Series/Earthquake/Services/EarthquakeWatchService.cs
class EarthquakeHistoryController
    extends StateNotifier<EarthquakeHistoryModel> {
  EarthquakeHistoryController()
      : super(
          const EarthquakeHistoryModel(
            telegrams: <Telegram>[],
            earthquakes: <EarthquakeItem>[],
          ),
        );

  /// 電文データ[telegram]を解析して、地震履歴に追加します
  void insertTelegramToEarthquakeHistory(Telegram telegram) {
    // 電文のタイプが処理対象内かどうかを確認する
    if (<String>['VXSE51', 'VXSE52', 'VXSE53', 'VXSE61']
        .contains(telegram.type)) {
      throw Exception('地震履歴解析対象外の電文タイプです。 ${telegram.type}');
    }
    if (telegram.id == null) {
      throw Exception('地震履歴解析対象の電文IDがnullです。 ${telegram.id}');
    }

    final eventId = int.parse(telegram.eventId!);
    final telegramType =
        DmDssTelegramDataType.values.firstWhere((e) => e.name == telegram.type);

    switch (telegramType) {

      /// 震度速報
      case DmDssTelegramDataType.VXSE53:
        // この電文のEventIdが既に地震履歴に存在するかを確認する
        final earthQuakeListIndex = _getEarthquakeHistoryIndex(eventId);
        // EventIdが存在している場合は、それを更新する
        if (earthQuakeListIndex != null) {
          final eq = state.earthquakes[earthQuakeListIndex];
          final EarthquakeItem newEq;
          if (telegram.serialNo == 1) {
            // serialNoが1の場合は、利用した電文リストに追加して終わる。
            if (eq.usedTelegrams.containsKey(telegramType)) {
              final usedTelegrams = eq.usedTelegrams
                ..update(
                  telegramType,
                  (value) => [...value, telegram],
                  ifAbsent: () => [telegram],
                );
              newEq = eq.copyWith(
                usedTelegrams: usedTelegrams,
              );
            }
          } else if (eq.usedTelegrams
              .containsKey(DmDssTelegramDataType.VXSE53)) {
            // serialNoが2以上の場合、かつVXSE53の電文を含む場合は
            // 利用した電文リストに追加して終わる。
            final usedTelegrams = eq.usedTelegrams
              ..update(
                telegramType,
                (value) => [...value, telegram],
                ifAbsent: () => [telegram],
              );
            newEq = eq.copyWith(
              usedTelegrams: usedTelegrams,
            );
          } else {
            // serialNoが2以上の場合、かつVXSE53の電文を含まない場合は、
            // 情報を更新して、利用した電文リストに追加して終わる。
            final usedTelegrams = eq.usedTelegrams
              ..update(
                telegramType,
                (value) => [...value, telegram],
                ifAbsent: () => [telegram],
              );
             newEq = eq.copyWith(
              headline: telegram.headline ?? eq.headline,
              maxIntensity: telegram.maxint ?? eq.maxIntensity,
              usedTelegrams: usedTelegrams,
            );
          }
          // 変更を適用
          state = state.copyWith(
            earthquakes:
                state.earthquakes.map((e) => e.id == eq.id ? newEq : e).toList(),
          );
        } else {
          // EventIdが存在していない場合は、新規に追加する
          final eq = EarthquakeItem(
            usedTelegrams: {
              DmDssTelegramDataType.VTSE51: <Telegram>[telegram]
            },
            id: eventId,
            isSokuhou: true,
            isOnlyPoint: false,
            isTraining: false,
            location: (telegram.lat != null && telegram.lon != null)
                ? LatLng(telegram.lat!, telegram.lon!)
                : null,
            isHypocenterOnly: false,
            time: telegram.time,
            isOriginTime: false,
            place: telegram.hypoName,
            maxIntensity: telegram.maxint ?? JmaIntensity.Unknown,
            magnitude: telegram.magnitudeCondition?.description ??
                ((telegram.magnitude != null)
                    ? 'M${telegram.magnitude}'
                    : null),
            headline: telegram.headline,
            comments: null,
            depth: telegram.depthCondition?.description ??
                ((telegram.depth != null) ? '${telegram.depth}km' : null),
            prefectures: null,
            regions: null,
          );
          state = state.copyWith(
            earthquakes: [...state.earthquakes, eq],
          );
        }

        break;

      /// 震源に関する情報
      case 'VXSE52':
        break;

      /// 震源・震度に関する情報
      case 'VXSE53':
        break;

      /// 顕著な地震の震源要素更新のお知らせ
      case 'VXSE61':
        break;

      default:
        throw Exception('地震履歴解析対象外の電文タイプです。 ${telegram.type}');
    }
  }

  /// 指定した電文IDを持つ地震履歴が既に存在しているかを確認
  /// する場合は、地震履歴配列のインデックスを返します。
  /// ない場合は、nullを返します。
  /// [telegramId] 電文ID
  int? _getEarthquakeHistoryIndex(int telegramId) {
    for (var i = 0; i < state.earthquakes.length; i++) {
      if (state.earthquakes[i].id == telegramId) {
        return i;
      }
    }
    return null;
  }

  /* /// ## VXSE51(震度速報)を解析して、地震履歴に追加する
  /// 震度速報(震度3以上の地域を90秒程度で第1報を発表) `earthquake-information`
  void _parseVxse51(Telegram telegram) {
    // 既存の地震履歴を取得
    final earthquakeHistory = state.earthquakes;
    assert(telegram.type == 'VXSE51');
    assert(telegram.data != null);
    final commonHead = CommonHead.fromJson(telegram.data!);
    final eqInfo = EarthquakeInformation.fromJson(commonHead.body);

    final maxInt = JmaIntensity.values.firstWhere(
      (e) => e.name == eqInfo.intensity?.maxInt,
      orElse: () => JmaIntensity.Unknown,
    );
    // このEventIdが既に地震履歴にあるかを確認
    if (earthquakeHistory.any((e) => e.id == commonHead.eventId)) {
      // 既存の地震情報を取得し、それを変更していく
      final eq = earthquakeHistory
          .firstWhere((e) => e.id == int.parse(commonHead.eventId.toString()));
      // 既に速報ではない情報が入ってきている場合は、更新しない
      if (!eq.isSokuhou) {
        return;
      }
      // 既に緊急地震速報以外の情報がある場合は、更新しない
      if (eq.usedTelegrams
          .any((e) => !['VXSE43', 'VXSE44', 'VXSE45'].contains(e.type))) {
        return;
      }
      final newEq = eq.copyWith(
        maxIntensity: maxInt,
        prefectures: eqInfo.intensity?.prefectures,
        isSokuhou: true,
        isOnlyPoint: false,
      );
      // 地震履歴に更新を適用
      earthquakeHistory[earthquakeHistory.indexOf(eq)] = newEq;
    } else {
      // 既存の地震情報がないので、新規作成する
      earthquakeHistory.add(
        EarthquakeItem(
          usedTelegrams: [telegram],
          id: int.parse(commonHead.eventId.toString()),
          isSokuhou: true,
          isOnlyPoint: false,
          isTraining: commonHead.status != CommonHeadStatus.normal,
          location: null,
          isHypocenterOnly: false,
          time: eqInfo.earthquake!.originTime,
          isOriginTime: true,
          place: null,
          maxIntensity: maxInt,
          magnitude: eqInfo.earthquake!.magnitude,
          headline: commonHead.headline,
          comments: eqInfo.comments,
          depth: eqInfo.earthquake!.hypoCenter.depth,
          prefectures: eqInfo.intensity?.prefectures,
          regions: eqInfo.intensity?.regions,
        ),
      );
    }
    state = state.copyWith(earthquakes: earthquakeHistory);
  }*/
}
