import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'changelog_section_model.freezed.dart';

@freezed
abstract class ChangelogSectionModel with _$ChangelogSectionModel {
  const factory({
    required String title,
    required List<String> items,
  }) = _ChangelogSectionModel;
}

extension ChangelogSectionApiExtension on api.ChangelogSection {
  ChangelogSectionModel toChangelogSectionModel() =>
      ChangelogSectionModel(title: title, items: items);
}
