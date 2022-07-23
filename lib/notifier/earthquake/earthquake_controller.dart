import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/model/earthquake/earthquake_item.dart';
import 'package:eqmonitor/model/earthquake/earthquake_log_model.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eq-information/earthquake-information.dart';
import 'package:eqmonitor/schema/supabase/telegram.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  /// ## VXSE51(震度速報)を解析して、地震履歴に追加する
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
  }
}
