enum RevenueCatUnavailableReason {
  unsupportedPlatform,
  apiKeyNotConfigured,
  registrationRequired,
  identityChanged,
}

final class const RevenueCatUnavailableException({
  required final RevenueCatUnavailableReason reason,
}) implements Exception {
  String get userMessage => switch (reason) {
    RevenueCatUnavailableReason.unsupportedPlatform => 'このプラットフォームでは購入できません',
    RevenueCatUnavailableReason.apiKeyNotConfigured => '現在この機能はご利用いただけません',
    RevenueCatUnavailableReason.registrationRequired => 'デバイスの登録完了後に再試行してください',
    RevenueCatUnavailableReason.identityChanged => 'デバイス情報が変更されました。再度お試しください',
  };

  @override
  String toString() => 'RevenueCatUnavailableException(reason: $reason)';
}
