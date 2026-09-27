/// プロビジョニング処理で発生しうるエラーの sealed 階層。
///
/// 全サブクラスは [userMessage]（UI 表示用）と [isRetryable]（自動再試行可否）を持つ。
sealed class const DeviceProvisioningException({
  final Object? cause,
  final StackTrace? stackTrace,
}) implements Exception {
  String get userMessage;
  bool get isRetryable;

  @override
  String toString() =>
      'DeviceProvisioningException(isRetryable: $isRetryable, cause: $cause)';
}

/// ネットワーク不通・タイムアウト・TLS エラー。
final class const NetworkUnreachableException({super.cause, super.stackTrace})
    extends DeviceProvisioningException {
  @override
  String get userMessage => 'ネットワークに接続できません';

  @override
  bool get isRetryable => true;
}

/// 5xx サーバーエラー。
final class const ServerErrorException({
  required final int statusCode,
  final String? body,
  super.cause,
  super.stackTrace,
}) extends DeviceProvisioningException {
  @override
  String get userMessage => 'サーバーエラーが発生しました';

  @override
  bool get isRetryable => true;
}

/// 400 / 422 リクエスト不正（バグまたは互換性の問題）。
final class const InvalidRequestException({
  required final int statusCode,
  final String? body,
  super.cause,
  super.stackTrace,
}) extends DeviceProvisioningException {
  @override
  String get userMessage => '無効なリクエストです';

  @override
  bool get isRetryable => false;
}

enum AuthorizationFailureReason {
  appCheckUnavailable,
  unauthenticated,
  forbidden,
}

/// 認証 / 認可エラー。AppCheck 失敗は再試行可能。
final class const AuthorizationException({
  required final AuthorizationFailureReason reason,
  super.cause,
  super.stackTrace,
}) extends DeviceProvisioningException {
  @override
  String get userMessage => switch (reason) {
    AuthorizationFailureReason.appCheckUnavailable => '認証トークンを取得できません',
    AuthorizationFailureReason.unauthenticated => '認証が必要です',
    AuthorizationFailureReason.forbidden => 'アクセスが拒否されました',
  };

  @override
  bool get isRetryable =>
      reason == AuthorizationFailureReason.appCheckUnavailable;
}

/// 429 レート制限。[retryAfter] が非 null の場合は優先的に使用する。
final class const RateLimitedException({
  final Duration? retryAfter,
  super.cause,
  super.stackTrace,
}) extends DeviceProvisioningException {
  @override
  String get userMessage => 'リクエストが多すぎます。しばらくお待ちください';

  @override
  bool get isRetryable => true;
}

enum PushTokenKind { fcm, apnsNotification, apnsPushToStart }

enum PushTokenFailureReason {
  permissionDenied,
  serviceUnavailable,
  notSupported,
  unknown,
}

/// プッシュトークン取得失敗。
final class const PushTokenUnavailableException({
  required final PushTokenKind kind,
  required final PushTokenFailureReason reason,
  super.cause,
  super.stackTrace,
}) extends DeviceProvisioningException {
  @override
  String get userMessage => switch (reason) {
    PushTokenFailureReason.permissionDenied => '通知の許可が必要です',
    PushTokenFailureReason.notSupported => '端末が通知をサポートしていません',
    _ => 'トークンの取得に失敗しました',
  };

  @override
  bool get isRetryable => switch (reason) {
    PushTokenFailureReason.serviceUnavailable ||
    PushTokenFailureReason.unknown => true,
    _ => false,
  };
}

/// SharedPreferences 書き込み失敗。
final class const LocalStorageException({super.cause, super.stackTrace})
    extends DeviceProvisioningException {
  @override
  String get userMessage => 'ローカルデータの保存に失敗しました';

  @override
  bool get isRetryable => true;
}

/// 上記に分類できない予期しないエラー。
final class const UnexpectedProvisioningException({
  super.cause,
  super.stackTrace,
}) extends DeviceProvisioningException {
  @override
  String get userMessage => '予期しないエラーが発生しました';

  @override
  bool get isRetryable => false;
}
