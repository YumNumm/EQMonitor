import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:cryptography/cryptography.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_signature.dart';

class AssetPackSignatureVerifier {
  AssetPackSignatureVerifier({required Map<String, List<int>> publicKeys})
    : publicKeys = Map.unmodifiable({
        for (final MapEntry(:key, :value) in publicKeys.entries)
          key: Uint8List.fromList(value),
      }) {
    if (this.publicKeys.values.any((key) => key.length != 32)) {
      throw ArgumentError.value(
        publicKeys,
        'publicKeys',
        'Ed25519 keys must be 32 bytes',
      );
    }
  }

  final Map<String, Uint8List> publicKeys;

  Future<bool> verify({
    required Uint8List content,
    required AssetPackSignature sidecar,
  }) async {
    final publicKey = publicKeys[sidecar.keyId];
    if (publicKey == null ||
        crypto.sha256.convert(content).toString() != sidecar.contentSha256) {
      return false;
    }
    return Ed25519().verify(
      content,
      signature: Signature(
        sidecar.signatureBytes,
        publicKey: SimplePublicKey(publicKey, type: KeyPairType.ed25519),
      ),
    );
  }
}
