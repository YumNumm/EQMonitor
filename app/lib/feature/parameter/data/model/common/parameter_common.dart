import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_common.freezed.dart';
part 'parameter_common.g.dart';

@freezed
abstract class LocalizedName with _$LocalizedName {
  const factory({
    required String ja,
    String? en,
    String? zhHans,
    String? zhHant,
    String? ko,
    String? es,
    String? pt,
    String? id,
    String? vi,
    String? tl,
    String? th,
    String? ne,
    String? km,
    String? my,
    String? mn,
  }) = _LocalizedName;

  factory fromJson(Map<String, dynamic> json) =>
      _$LocalizedNameFromJson(json);
}
