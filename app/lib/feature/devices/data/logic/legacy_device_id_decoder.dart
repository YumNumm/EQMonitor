import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// ローカルの移行元 ID を読むだけで、JWT の認証・認可は行わない。
final class const LegacyDeviceIdDecoder() {
  String? decode(String? token) {
    if (token == null || token.isEmpty) {
      return null;
    }
    final parts = token.split('.');
    if (parts.length != 3 || parts.any((part) => part.isEmpty)) {
      return null;
    }
    try {
      final payload = JWT.decode(token).payload;
      if (payload is! Map<String, dynamic>) {
        return null;
      }
      final id = payload['id'];
      return id is String && isValid(id) ? id : null;
    } on JWTException {
      return null;
    }
  }

  bool isValid(String id) => RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  ).hasMatch(id);
}
