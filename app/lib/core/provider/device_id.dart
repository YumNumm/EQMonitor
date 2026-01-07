import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_id.g.dart';

/// デバイスIDを提供するProvider
/// UDIDのSHA512ハッシュをUUID形式に変換して返す
@Riverpod(keepAlive: true)
Future<String> deviceId(Ref ref) async {
  final udid = await FlutterUdid.udid;
  final bytes = utf8.encode(udid);
  final digest = sha512.convert(bytes);
  final hash = digest.toString();

  // SHA512ハッシュ（128文字）をUUID形式（8-4-4-4-12）に変換
  return '${hash.substring(0, 8)}-${hash.substring(8, 12)}-${hash.substring(12, 16)}-${hash.substring(16, 20)}-${hash.substring(20, 32)}';
}
