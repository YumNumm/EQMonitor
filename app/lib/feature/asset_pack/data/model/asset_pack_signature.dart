import 'dart:convert';
import 'dart:typed_data';

final _keyIdPattern = RegExp(r'^[a-z0-9][a-z0-9-]{0,63}$');
final _sha256Pattern = RegExp(r'^[0-9a-f]{64}$');

class AssetPackSignature {
  const new({
    required this.schemaVersion,
    required this.algorithm,
    required this.keyId,
    required this.contentSha256,
    required this.signatureBytes,
  });

  factory fromJson(Map<String, dynamic> json) {
    final schemaVersion = json['schema_version'];
    final algorithm = json['algorithm'];
    final keyId = json['key_id'];
    final contentSha256 = json['content_sha256'];
    final signatureBase64 = json['signature_base64'];
    if (schemaVersion != 1 || algorithm != 'Ed25519') {
      throw const FormatException('Unsupported Asset Pack signature');
    }
    if (keyId is! String || !_keyIdPattern.hasMatch(keyId)) {
      throw const FormatException('Invalid Asset Pack signature key_id');
    }
    if (contentSha256 is! String || !_sha256Pattern.hasMatch(contentSha256)) {
      throw const FormatException('Invalid Asset Pack content_sha256');
    }
    if (signatureBase64 is! String) {
      throw const FormatException('Invalid Asset Pack signature_base64');
    }
    final Uint8List signatureBytes;
    try {
      signatureBytes = base64Decode(signatureBase64);
    } on FormatException {
      throw const FormatException('Invalid Asset Pack signature_base64');
    }
    if (signatureBytes.length != 64) {
      throw const FormatException('Ed25519 signature must be 64 bytes');
    }
    return AssetPackSignature(
      schemaVersion: schemaVersion,
      algorithm: algorithm,
      keyId: keyId,
      contentSha256: contentSha256,
      signatureBytes: signatureBytes,
    );
  }

  final int schemaVersion;
  final String algorithm;
  final String keyId;
  final String contentSha256;
  final Uint8List signatureBytes;
}
