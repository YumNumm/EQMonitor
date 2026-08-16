import 'dart:convert';
import 'dart:typed_data';

import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_signature.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_signature_verifier.dart';
import 'package:flutter_test/flutter_test.dart';

final publicKey = Uint8List.fromList(
  hexToBytes(
    'd75a980182b10ab7d54bfed3c964073a'
    '0ee172f3daa62325af021a68f707511a',
  ),
);
final signatureBytes = hexToBytes(
  'e5564300c360ac729086e2cc806e828a'
  '84877f1eb8e5d974d873e06522490155'
  '5fb8821590a33bacc61e39701cf9b46b'
  'd25bf5f0595bbe24655141438e7a100b',
);

AssetPackSignature signature() => AssetPackSignature.fromJson({
  'schema_version': 1,
  'algorithm': 'Ed25519',
  'key_id': 'test-key',
  'content_sha256':
      'e3b0c44298fc1c149afbf4c8996fb924'
      '27ae41e4649b934ca495991b7852b855',
  'signature_base64': base64Encode(signatureBytes),
});

void main() {
  group('AssetPackSignature', () {
    test('parses the versioned Ed25519 sidecar', () {
      final parsed = signature();

      expect(parsed.keyId, 'test-key');
      expect(parsed.signatureBytes, signatureBytes);
    });

    test('rejects unknown algorithm and malformed fields', () {
      final valid = {
        'schema_version': 1,
        'algorithm': 'Ed25519',
        'key_id': 'test-key',
        'content_sha256': 'a' * 64,
        'signature_base64': base64Encode(signatureBytes),
      };
      for (final invalid in [
        {...valid, 'algorithm': 'RSA'},
        {...valid, 'key_id': '../key'},
        {...valid, 'content_sha256': 'bad'},
        {...valid, 'signature_base64': 'bad'},
      ]) {
        expect(
          () => AssetPackSignature.fromJson(invalid),
          throwsFormatException,
        );
      }
    });
  });

  group('AssetPackSignatureVerifier', () {
    test('matches the RFC 8032 Ed25519 empty-message vector', () async {
      final verifier = AssetPackSignatureVerifier(
        publicKeys: {'test-key': publicKey},
      );

      expect(
        await verifier.verify(content: Uint8List(0), sidecar: signature()),
        isTrue,
      );
    });

    test('rejects changed content and an unknown key id', () async {
      final verifier = AssetPackSignatureVerifier(
        publicKeys: {'test-key': publicKey},
      );

      expect(
        await verifier.verify(
          content: Uint8List.fromList(utf8.encode('changed')),
          sidecar: signature(),
        ),
        isFalse,
      );
      expect(
        await AssetPackSignatureVerifier(
          publicKeys: const {},
        ).verify(content: Uint8List(0), sidecar: signature()),
        isFalse,
      );
    });
  });
}

List<int> hexToBytes(String value) => [
  for (var index = 0; index < value.length; index += 2)
    int.parse(value.substring(index, index + 2), radix: 16),
];
