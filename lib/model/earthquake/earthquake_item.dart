import 'package:eqmonitor/schema/dmdata/eq-information/earthquake-information/intensity/prefecture.dart';
import 'package:eqmonitor/schema/dmdata/eq-information/earthquake-information/intensity/region.dart';
import 'package:eqmonitor/schema/dmdata/websocketv2/type.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../const/kmoni/jma_intensity.dart';
import '../../schema/dmdata/eq-information/comments.dart';
import '../../schema/dmdata/eq-information/earthquake-information/hypocenter/depth.dart';
import '../../schema/dmdata/eq-information/earthquake-information/magnitude.dart';
import '../../schema/supabase/telegram.dart';

part 'earthquake_item.freezed.dart';

/// ## 地震情報
/// ref: https://github.com/ingen084/KyoshinEewViewerIngen/blob/2801ad7959f99abe7ac81c2ff3a7d1974716a786/src/KyoshinEewViewer/Series/EarthquakeItem/Models/EarthquakeItem.cs
@freezed
class EarthquakeItem with _$EarthquakeItem {
  const factory EarthquakeItem({
    /// この地震情報に用いた電文
    required Map<DmDssTelegramDataType, List<Telegram>> usedTelegrams,

    /// 地震ID
    required int id,

    /// 速報かどうか(VXSE53発表前かどうか)
    required bool isSokuhou,

    ///
    required bool isOnlyPoint,

    /// 訓練報を一度でも含んだかどうか
    required bool isTraining,

    /// 震央地の座標
    required LatLng? location,

    /// 震源情報を受信したかどうか
    required bool isHypocenterOnly,

    /// 地震発生時刻もしくは、地震検知時刻
    required DateTime time,

    /// 地震発生時刻かどうか
    required bool isOriginTime,

    /// 震央地名 不明な場合はnull
    required String? place,

    /// 最大震度
    required JmaIntensity maxIntensity,

    /// マグニチュード
    required String? magnitude,
    required String? headline,
    required String? comments,
    required String? depth,

    /// 都道府県内における最大震度
    required List<Prefecture>? prefectures,

    /// 一次細分化地域内における最大震度
    required List<Region>? regions,
  }) = _EarthquakeItem;

  /// 通知に用いる文字列を生成する
  String getNotificationMessage() {
    final sb = StringBuffer();
    if (isTraining) {
      sb.write('[訓練]');
    }

    sb

      /// 最大震度
      ..write(
        (maxIntensity == JmaIntensity.Unknown)
            ? '最大震度不明'
            : '最大震度${maxIntensity.name}',
      )
      // 震源地名
      ..write(' 震央地:${place ?? '不明'}');
    // 深さ
    if (depth.condition != null) {
      sb.write(' 深さ:${depth.condition!.description}');
    } else if (depth.value != null) {
      sb.write(' 深さ:${depth.value}km');
    }
    // マグニチュード
    if (magnitude.condition != null) {
      sb.write(' マグニチュード:${magnitude.condition!.description}');
    } else if (magnitude.value != null) {
      sb.write(' マグニチュード:${magnitude.value}');
    }
    return sb.toString();
  }

  /// usedTelegramsのMapをListに変換して返す
  List<Telegram> getAllTelegram() {
    final result = <Telegram>[];
    usedTelegrams.forEach((type, telegrams) {
      result.addAll(telegrams);
    });
    return result;
  }
}
