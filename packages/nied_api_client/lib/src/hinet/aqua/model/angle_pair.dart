import 'package:freezed_annotation/freezed_annotation.dart';

part 'angle_pair.freezed.dart';
part 'angle_pair.g.dart';

@freezed
abstract class AnglePair with _$AnglePair {
  const factory AnglePair({
    required double first,
    required double second,
  }) = _AnglePair;

  factory AnglePair.fromJson(Map<String, dynamic> json) =>
      _$AnglePairFromJson(json);
}
