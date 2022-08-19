import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'analyzed_kyoshin_kansokuten.dart';

part 'kmoni_model.freezed.dart';

@freezed
class KmoniModel with _$KmoniModel {
  const factory KmoniModel({
    /// 観測点のリスト
    required List<AnalyzedKoshinKansokuten> analyzedPoint,

    /// 最新の更新時刻
    /// `Null`の時は、まだ更新されていません
    required DateTime? lastUpdated,

    /// 最終更新試行時
    /// デフォルトは 現在時刻
    required DateTime lastUpdateAttempt,


    /// Kmoniの更新タイマー
    required Timer? updateTimer,

    /// Kmoniの更新頻度
    required Duration updateFrequency,

    /// Kmoniの更新中かどうか
    required bool isUpdating,
  }) = _KmoniModel;
}
