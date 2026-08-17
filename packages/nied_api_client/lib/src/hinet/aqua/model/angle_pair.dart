import 'package:freezed_annotation/freezed_annotation.dart';

part 'angle_pair.freezed.dart';
part 'angle_pair.g.dart';

@freezed
abstract class AnglePair with _$AnglePair {
  const factory({
    required double first,
    required double second,
  }) = _AnglePair;

  factory fromJson(Map<String, dynamic> json) =>
      _$AnglePairFromJson(json);
}
