// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'code_name.dart';
import 'coordinate.dart';
import 'depth.dart';
import 'hypocenter_auxiliary.dart';
import 'magnitude.dart';

part 'tsunami_state_hypocenter.freezed.dart';
part 'tsunami_state_hypocenter.g.dart';

@Freezed()
abstract class TsunamiStateHypocenter with _$TsunamiStateHypocenter {
  const factory TsunamiStateHypocenter({
    required CodeName value,
    required Depth depth,
    required Magnitude magnitude,
    @JsonKey(includeIfNull: false)
    Coordinate? coordinates,
    @JsonKey(includeIfNull: false)
    HypocenterAuxiliary? auxiliary,
  }) = _TsunamiStateHypocenter;
  
  factory TsunamiStateHypocenter.fromJson(Map<String, Object?> json) => _$TsunamiStateHypocenterFromJson(json);
}
