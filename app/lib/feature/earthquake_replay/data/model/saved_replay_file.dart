import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_replay_file.freezed.dart';

@freezed
abstract class const SavedReplayFile._() with _$SavedReplayFile {
  const factory({
    required String path,
    required String name,
    required int sizeBytes,
    required DateTime modifiedAt,
  }) = _SavedReplayFile;

  Uri get uri => Uri.file(path);
}
