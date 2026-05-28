enum RevenueCatUnavailableReason {
  unsupportedPlatform,
  apiKeyNotConfigured,
}

final class RevenueCatUnavailableException implements Exception {
  const RevenueCatUnavailableException({required this.reason});

  final RevenueCatUnavailableReason reason;

  String get userMessage => switch (reason) {
    RevenueCatUnavailableReason.unsupportedPlatform => 'このプラットフォームでは購入できません',
    RevenueCatUnavailableReason.apiKeyNotConfigured => '現在この機能はご利用いただけません',
  };

  @override
  String toString() => 'RevenueCatUnavailableException(reason: $reason)';
}
