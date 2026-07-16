/// プッシュ通知トークンの取得・監視に関わるプラットフォームを表す。
enum PushTokenPlatform { android, ios, unsupported }

/// プラットフォームごとに、どのプッシュトークン種別を扱えるかを表す。
///
/// iOSのLive Activity push-to-start tokenはiOS 18以上でのみ利用可能なため、
/// [supportsPushToStart] はiOSのメジャーバージョンが18以上であることを
/// 確認できた場合にのみ `true` になる。
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
