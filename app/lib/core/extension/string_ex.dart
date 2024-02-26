import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

extension Sha512Ex on String {
  String get sha512 => crypto.sha512
      .convert(
        utf8.encode(this),
      )
      .toString();
}
