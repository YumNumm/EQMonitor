import 'package:eqmonitor/model/db/eq_history.schema.dart';
import 'package:eqmonitor/schema/svir/svirResponse.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'eew.model.freezed.dart';

@freezed
class EEWModel with _$EEWModel {
  const factory EEWModel({
    required List<SvirResponse> responses,
    required int apiFetchDuration,
  }) = _EEWModel;
}
