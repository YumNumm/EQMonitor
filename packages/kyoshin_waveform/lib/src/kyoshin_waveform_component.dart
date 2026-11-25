enum KyoshinSensorPosition { surface, borehole }

enum KyoshinWaveformAxis { northSouth, eastWest, upDown }

enum KyoshinWaveformComponent(
  final String label,
  final String direction,
  final KyoshinSensorPosition position,
  final KyoshinWaveformAxis axis,
) {
  ns('NS', 'N-S', .surface, .northSouth),
  ew('EW', 'E-W', .surface, .eastWest),
  ud('UD', 'U-D', .surface, .upDown),
  ns1('NS1', '1', .borehole, .northSouth),
  ew1('EW1', '2', .borehole, .eastWest),
  ud1('UD1', '3', .borehole, .upDown),
  ns2('NS2', '4', .surface, .northSouth),
  ew2('EW2', '5', .surface, .eastWest),
  ud2('UD2', '6', .surface, .upDown);

  static KyoshinWaveformComponent fromDirection(String direction) {
    for (final component in values) {
      if (component.direction == direction) {
        return component;
      }
    }
    throw FormatException('Unknown K-NET direction', direction);
  }
}
