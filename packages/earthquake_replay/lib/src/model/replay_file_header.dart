import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_file_header.freezed.dart';
part 'replay_file_header.g.dart';

@freezed
class ReplayFileHeader with _$ReplayFileHeader {
  const factory ReplayFileHeader({
    required int version,
    required String softwareName,
    required DateTime startTime,
    required DateTime endTime,
    required ReplayFileCompressionMode compressionMode,
  }) = _ReplayFileHeader;

  factory ReplayFileHeader.fromJson(Map<String, dynamic> json) =>
      _$ReplayFileHeaderFromJson(json);

  factory ReplayFileHeader.fromMsgPack(List<dynamic> data) {
    final compressionModeValue = data[4] as int;
    return ReplayFileHeader(
      version: data[0] as int,
      softwareName: data[1] as String,
      startTime: DateTime.fromMillisecondsSinceEpoch(data[2] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(data[3] as int),
      compressionMode: ReplayFileCompressionMode.values.firstWhere(
        (e) => e.value == compressionModeValue,
      ),
    );
  }
}

enum ReplayFileCompressionMode {
  none(0),
  messagePackCSharpLz4BlockArray(1),
  gzip(2),
  brotil(3),
  ;

  const ReplayFileCompressionMode(this.value);
  final int value;
}
