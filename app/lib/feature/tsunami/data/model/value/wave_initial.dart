import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum WaveInitial {
  push,
  pull,
}

extension WaveInitialApiExt on api.WaveInitial {
  WaveInitial toDomain() => switch (this) {
    api.WaveInitial.push => WaveInitial.push,
    api.WaveInitial.pull => WaveInitial.pull,
  };
}
