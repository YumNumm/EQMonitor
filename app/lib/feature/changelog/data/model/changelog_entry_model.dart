import 'package:eqmonitor/feature/changelog/data/model/changelog_section_model.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'changelog_entry_model.freezed.dart';

@freezed
abstract class ChangelogEntryModel with _$ChangelogEntryModel {
  const factory({
    required String version,
    required DateTime date,
    required String url,
    required List<ChangelogSectionModel> sections,
    String? content,
  }) = _ChangelogEntryModel;
}

extension ChangelogEntryApiExtension on api.ChangelogEntry {
  ChangelogEntryModel toChangelogEntryModel() => ChangelogEntryModel(
    version: version,
    date: date,
    url: url,
    sections: sections.map((e) => e.toChangelogSectionModel()).toList(),
    content: content,
  );
}
