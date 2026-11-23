import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_replay_file.freezed.dart';

@freezed
abstract class const SavedReplayFile._() with _$SavedReplayFile {
  /// [directory] は保存先のルートからの相対パス（区切りは `/`）。ルート直下は空文字。
  const factory({
    required String path,
    required String name,
    required String directory,
    required int sizeBytes,
    required DateTime modifiedAt,
  }) = _SavedReplayFile;

  Uri get uri => Uri.file(path);

  String get location => directory.isEmpty ? name : '$directory/$name';
}
