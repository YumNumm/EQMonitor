import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:eqmonitor/feature/devices/data/logic/device_id_decoder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const decoder = DeviceIdDecoder();

  test('署名と有効期限を検証せず sub から Device ID を取り出す', () {
    final signedToken = JWT({
      'sub': 'device:01976d8e-7d12-7000-8000-1234567890ab',
      'exp': 0,
    }).sign(SecretKey('test-secret'));
    final parts = signedToken.split('.');
    final tokenWithInvalidSignature = '${parts[0]}.${parts[1]}.invalid';

    expect(
      decoder.decode(token: tokenWithInvalidSignature),
      '01976d8e-7d12-7000-8000-1234567890ab',
    );
  });

  test('JWT が不正な場合は FormatException を投げる', () {
    expect(
      () => decoder.decode(token: 'not-a-jwt'),
      throwsA(isA<FormatException>()),
    );
  });

  test('sub が文字列でない場合は FormatException を投げる', () {
    final token = JWT({'sub': 123}).sign(SecretKey('test-secret'));

    expect(
      () => decoder.decode(token: token),
      throwsA(isA<FormatException>()),
    );
  });

  test('sub が device prefix を持たない場合は FormatException を投げる', () {
    final token = JWT({
      'sub': '01976d8e-7d12-7000-8000-1234567890ab',
    }).sign(SecretKey('test-secret'));

    expect(
      () => decoder.decode(token: token),
      throwsA(isA<FormatException>()),
    );
  });

  test('sub の Device ID が空の場合は FormatException を投げる', () {
    final token = JWT({'sub': 'device:'}).sign(SecretKey('test-secret'));

    expect(
      () => decoder.decode(token: token),
      throwsA(isA<FormatException>()),
    );
  });
}
