import 'dart:convert';
import 'dart:io';

import 'package:earthquake_replay/earthquake_replay.dart';

// usage: dart run tool/filter_eew.dart <input.eqrp> [<output.eqrp> <event-id>...]
// 出力先を省くと、EEW のフレームを地震ごとに数えて表示する。指定すると、挙げた event ID 以外の EEW のフレームを除いて書き出す。
void main(List<String> arguments) {
  final file = ReplayDataParser().parse(File(arguments[0]).readAsBytesSync());
  String? eventIdOf(ReplayData frame) => switch (frame) {
    EqMonitorEewReplayData(:final json) =>
      ((jsonDecode(json) as Map<String, dynamic>)['event_id'] ??
              (jsonDecode(json) as Map<String, dynamic>)['eventId'])
          ?.toString(),
    _ => null,
  };

  if (arguments.length == 1) {
    stdout.writeln(
      '${file.header.softwareName} ${file.header.startTime} - ${file.header.endTime}',
    );
    final types = <ReplayDataType, int>{};
    final events = <String, List<DateTime>>{};
    for (final frame in file.data) {
      types[frame.type] = (types[frame.type] ?? 0) + 1;
      if (frame is EqMonitorEewReplayData) {
        events.putIfAbsent(eventIdOf(frame) ?? '?', () => []).add(frame.time);
      }
    }
    stdout.writeln(types);
    for (final MapEntry(:key, :value) in events.entries) {
      stdout.writeln('$key: ${value.length} frames ${value.first} - ${value.last}');
    }
    return;
  }

  final keep = arguments.skip(2).toSet();
  final frames = [
    for (final frame in file.data)
      if (frame is! EqMonitorEewReplayData || keep.contains(eventIdOf(frame)))
        frame,
  ];
  File(arguments[1]).writeAsBytesSync(
    const ReplayDataWriter().write(
      softwareName: file.header.softwareName,
      startTime: file.header.startTime,
      endTime: file.header.endTime,
      frames: frames,
    ),
  );
  stdout.writeln('kept ${frames.length} of ${file.data.length} frames');
}
