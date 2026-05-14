import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/exception/app_check_rejection.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';

/// [DioException] を [DeviceProvisioningException] の型付き例外にマッピングする。
DeviceProvisioningException mapDioToProvisioningException(
  DioException e, [
  StackTrace? stack,
]) {
  // AppCheck 失敗は最優先で判定
  if (e.type == DioExceptionType.cancel && e.error is AppCheckRejection) {
    return AuthorizationException(
      reason: AuthorizationFailureReason.appCheckUnavailable,
      cause: e,
      stackTrace: stack,
    );
  }

  return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate =>
      NetworkUnreachableException(cause: e, stackTrace: stack),
    DioExceptionType.badResponse => _fromStatus(
      e.response?.statusCode,
      e,
      stack,
    ),
    _ => UnexpectedProvisioningException(cause: e, stackTrace: stack),
  };
}

DeviceProvisioningException _fromStatus(
  int? statusCode,
  DioException e,
  StackTrace? stack,
) {
  final body = e.response?.data?.toString();
  return switch (statusCode) {
    401 => AuthorizationException(
      reason: AuthorizationFailureReason.unauthenticated,
      cause: e,
      stackTrace: stack,
    ),
    403 => AuthorizationException(
      reason: AuthorizationFailureReason.forbidden,
      cause: e,
      stackTrace: stack,
    ),
    429 => RateLimitedException(
      retryAfter: _parseRetryAfter(e.response),
      cause: e,
      stackTrace: stack,
    ),
    400 || 422 => InvalidRequestException(
      statusCode: statusCode!,
      body: body,
      cause: e,
      stackTrace: stack,
    ),
    final s when s != null && s >= 500 => ServerErrorException(
      statusCode: s,
      body: body,
      cause: e,
      stackTrace: stack,
    ),
    _ => UnexpectedProvisioningException(cause: e, stackTrace: stack),
  };
}

Duration? _parseRetryAfter(Response<dynamic>? response) {
  final header = response?.headers.value('Retry-After');
  if (header == null) {
    return null;
  }
  final seconds = int.tryParse(header);
  if (seconds != null) {
    return Duration(seconds: seconds);
  }
  return null;
}
