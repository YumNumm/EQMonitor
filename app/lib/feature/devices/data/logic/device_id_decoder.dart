import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_id_decoder.g.dart';

@riverpod
DeviceIdDecoder deviceIdDecoder(Ref ref) => const DeviceIdDecoder();

final class DeviceIdDecoder {
  const new();

  String decode({required String token}) {
    try {
      final payload = JWT.decode(token).payload;
      if (payload is! Map<String, dynamic>) {
        throw const FormatException('JWT payload must be an object');
      }
      final subject = payload['sub'];
      if (subject is! String || !subject.startsWith('device:')) {
        throw const FormatException(
          'JWT sub must use the device:<id> format',
        );
      }
      final deviceId = subject.substring('device:'.length);
      if (deviceId.isEmpty) {
        throw const FormatException('JWT device id must not be empty');
      }
      return deviceId;
    } on JWTException catch (exception) {
      throw FormatException('Unable to decode device JWT: $exception');
    }
  }
}
