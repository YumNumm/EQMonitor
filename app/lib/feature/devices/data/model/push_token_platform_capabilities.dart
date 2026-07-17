enum PushTokenPlatform { android, ios, unsupported }

final class PushTokenPlatformCapabilities {
  const PushTokenPlatformCapabilities({
    this.supportsFcm = false,
    this.supportsApns = false,
    this.supportsPushToStart = false,
  });

  factory PushTokenPlatformCapabilities.forPlatform({
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

  final bool supportsFcm;
  final bool supportsApns;
  final bool supportsPushToStart;
}
