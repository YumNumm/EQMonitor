import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final occurredAt = DateTime.utc(2026, 7, 3, 12, 34, 56);

  String subject({
    Object error = 'boom',
    StackTrace? stackTrace,
    bool includeStackTrace = false,
  }) => buildErrorDiagnostics(
    error: error,
    stackTrace: stackTrace,
    deviceId: 'device-123',
    appVersion: '2.6.0',
    buildNumber: '4200',
    os: 'iOS 26.1',
    occurredAt: occurredAt,
    includeStackTrace: includeStackTrace,
  );

  test('基本情報をすべて含む', () {
    final text = subject();
    expect(text, contains('device-123'));
    expect(text, contains('2.6.0'));
    expect(text, contains('4200'));
    expect(text, contains('iOS 26.1'));
    expect(text, contains('2026-07-03T12:34:56'));
    expect(text, contains('boom'));
  });

  test('includeStackTrace=false のときスタックトレースを含めない', () {
    final st = StackTrace.fromString('STACK_MARKER');
    expect(subject(stackTrace: st), isNot(contains('STACK_MARKER')));
  });

  test('includeStackTrace=true かつ stackTrace ありでスタックトレースを含む', () {
    final st = StackTrace.fromString('STACK_MARKER');
    expect(
      subject(stackTrace: st, includeStackTrace: true),
      contains('STACK_MARKER'),
    );
  });

  test('DioException の HTTP ステータスを含む', () {
    final dio = DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response<dynamic>(
        requestOptions: RequestOptions(path: '/x'),
        statusCode: 503,
      ),
    );
    expect(subject(error: dio), contains('503'));
  });
}
