enum KyoshinSensorPosition { surface, borehole }

enum KyoshinWaveformAxis { northSouth, eastWest, upDown }

enum KyoshinWaveformComponent(
  final String label,
  final KyoshinSensorPosition position,
  final KyoshinWaveformAxis axis,
) {
  ns('NS', .surface, .northSouth),
  ew('EW', .surface, .eastWest),
  ud('UD', .surface, .upDown),
  ns1('NS1', .borehole, .northSouth),
  ew1('EW1', .borehole, .eastWest),
  ud1('UD1', .borehole, .upDown),
  ns2('NS2', .surface, .northSouth),
  ew2('EW2', .surface, .eastWest),
  ud2('UD2', .surface, .upDown),
}
