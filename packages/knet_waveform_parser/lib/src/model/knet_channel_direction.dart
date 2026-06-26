/// K-NET/KiK-net チャンネル方向
enum KnetChannelDirection {
  /// 南北方向
  ns('N-S'),

  /// 東西方向
  ew('E-W'),

  /// 上下方向
  ud('U-D'),

  /// KiK-net 地下 南北方向
  ns2('N-S2'),

  /// KiK-net 地下 東西方向
  ew2('E-W2'),

  /// KiK-net 地下 上下方向
  ud2('U-D2');

  const KnetChannelDirection(this.label);
  final String label;

  static KnetChannelDirection fromString(String value) {
    final normalized = value.trim().toUpperCase();
    for (final dir in values) {
      if (dir.label.toUpperCase() == normalized ||
          dir.name.toUpperCase() == normalized) {
        return dir;
      }
    }
    throw ArgumentError('Unknown channel direction: $value');
  }
}
