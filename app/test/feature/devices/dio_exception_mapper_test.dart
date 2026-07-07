import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/exception/app_check_rejection.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/exception/dio_exception_mapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _badResponse(int status, {Map<String, List<String>>? headers}) {
  final options = RequestOptions(path: '/v2/device');
  return DioException.badResponse(
    statusCode: status,
    requestOptions: options,
    response: Response(
      requestOptions: options,
      statusCode: status,
      headers: Headers.fromMap(headers ?? {}),
    ),
  );
}

DioException _typed(DioExceptionType type) => DioException(
  requestOptions: RequestOptions(path: '/v2/device'),
  type: type,
);

void main() {
  test('AppCheckRejection を伴う cancel は appCheckUnavailable', () {
    final e = DioException(
      requestOptions: RequestOptions(path: '/v2/device'),
      type: DioExceptionType.cancel,
      error: AppCheckRejection(
        FirebaseException(plugin: 'app_check', code: 'unknown'),
      ),
    );
    final mapped = mapDioToProvisioningException(e);
    expect(mapped, isA<AuthorizationException>());
    expect(
      (mapped as AuthorizationException).reason,
      AuthorizationFailureReason.appCheckUnavailable,
    );
    expect(mapped.isRetryable, isTrue);
  });

  for (final type in [
    DioExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.connectionError,
    DioExceptionType.badCertificate,
  ]) {
    test('$type は NetworkUnreachableException', () {
      expect(
        mapDioToProvisioningException(_typed(type)),
        isA<NetworkUnreachableException>(),
      );
    });
  }

  test('401 は unauthenticated (再試行不可)', () {
    final mapped = mapDioToProvisioningException(_badResponse(401));
    expect(mapped, isA<AuthorizationException>());
    expect(
      (mapped as AuthorizationException).reason,
      AuthorizationFailureReason.unauthenticated,
    );
    expect(mapped.isRetryable, isFalse);
  });

  test('403 は forbidden', () {
    final mapped = mapDioToProvisioningException(_badResponse(403));
    expect(mapped, isA<AuthorizationException>());
    expect(
      (mapped as AuthorizationException).reason,
      AuthorizationFailureReason.forbidden,
    );
  });

  test('429 は RateLimitedException で Retry-After 秒数を解析する', () {
    final mapped = mapDioToProvisioningException(
      _badResponse(429, headers: {'Retry-After': ['30']}),
    );
    expect(mapped, isA<RateLimitedException>());
    expect(
      (mapped as RateLimitedException).retryAfter,
      const Duration(seconds: 30),
    );
  });

  test('429 で Retry-After が無ければ retryAfter は null', () {
    final mapped = mapDioToProvisioningException(_badResponse(429));
    expect((mapped as RateLimitedException).retryAfter, isNull);
  });

  test('429 で Retry-After が HTTP-date 形式なら null (未対応)', () {
    final mapped = mapDioToProvisioningException(
      _badResponse(429, headers: {
        'Retry-After': ['Wed, 21 Oct 2026 07:28:00 GMT'],
      }),
    );
    expect((mapped as RateLimitedException).retryAfter, isNull);
  });

  test('400 は InvalidRequestException', () {
    final mapped = mapDioToProvisioningException(_badResponse(400));
    expect(mapped, isA<InvalidRequestException>());
    expect((mapped as InvalidRequestException).statusCode, 400);
    expect(mapped.isRetryable, isFalse);
  });

  test('422 は InvalidRequestException', () {
    expect(
      mapDioToProvisioningException(_badResponse(422)),
      isA<InvalidRequestException>(),
    );
  });

  test('500/503 は ServerErrorException (再試行可)', () {
    for (final status in [500, 503]) {
      final mapped = mapDioToProvisioningException(_badResponse(status));
      expect(mapped, isA<ServerErrorException>());
      expect((mapped as ServerErrorException).statusCode, status);
      expect(mapped.isRetryable, isTrue);
    }
  });

  test('未知のステータス (418) は UnexpectedProvisioningException', () {
    expect(
      mapDioToProvisioningException(_badResponse(418)),
      isA<UnexpectedProvisioningException>(),
    );
  });

  test('badResponse で statusCode が null なら Unexpected', () {
    final options = RequestOptions(path: '/v2/device');
    final e = DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
    );
    expect(
      mapDioToProvisioningException(e),
      isA<UnexpectedProvisioningException>(),
    );
  });

  test('unknown タイプは UnexpectedProvisioningException', () {
    expect(
      mapDioToProvisioningException(_typed(DioExceptionType.unknown)),
      isA<UnexpectedProvisioningException>(),
    );
  });
}
