import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';

typedef ReplayFileEncodeInput = ({
  DateTime startTime,
  DateTime endTime,
  List<ReplayData> frames,
});

class const ReplayFileEncoder() {
  static const softwareName = 'EQMonitor';

  Uint8List encode(ReplayFileEncodeInput input) =>
      const ReplayDataWriter().write(
        softwareName: softwareName,
        startTime: input.startTime,
        endTime: input.endTime,
        frames: input.frames,
      );
}
