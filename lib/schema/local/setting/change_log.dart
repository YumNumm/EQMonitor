import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_log.freezed.dart';
part 'change_log.g.dart';

class ChangeLog {
  ChangeLog({
    required this.items,
  });

  factory ChangeLog.fromJson(Map<String, dynamic> json) => ChangeLog(
        items: List<ChangeLogItem>.from(
          (json['items'] as List).map((e) {
            return ChangeLogItem.fromJson(e as Map<String, dynamic>);
          }),
        ),
      );

  final List<ChangeLogItem> items;
}

@freezed
class ChangeLogItem with _$ChangeLogItem {
  const factory ChangeLogItem({
    required bool isBreakingChange,
    required String version,
    required DateTime date,
    required String comment,
    required String url,
    required int buildId,
  }) = _ChangeLogItem;

  factory ChangeLogItem.fromJson(Map<String, dynamic> json) =>
      _$ChangeLogItemFromJson(json);
}
