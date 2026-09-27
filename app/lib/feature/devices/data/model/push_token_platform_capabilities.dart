enum PushTokenPlatform { android, ios, unsupported }

final class const PushTokenPlatformCapabilities({
  final bool supportsFcm = false,
  final bool supportsApns = false,
  final bool supportsPushToStart = false,
}) {
  factory forPlatform({
    required PushTokenPlatform platform,
    int? iosMajorVersion,
  }) => switch (platform) {
    .android => const PushTokenPlatformCapabilities(supportsFcm: true),
    .ios => PushTokenPlatformCapabilities(
      supportsFcm: true,
      supportsApns: true,
      supportsPushToStart: (iosMajorVersion ?? 0) >= 18,
    ),
    .unsupported => const PushTokenPlatformCapabilities(),
  };
}
