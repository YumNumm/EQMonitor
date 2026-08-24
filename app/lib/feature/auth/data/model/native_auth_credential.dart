import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

enum NativeAuthProvider { google, apple }

final class AppleInitialUser {
  const new({this.email, this.firstName, this.lastName});

  final String? email;
  final String? firstName;
  final String? lastName;

  bool get hasValue =>
      email?.isNotEmpty == true ||
      firstName?.isNotEmpty == true ||
      lastName?.isNotEmpty == true;

  Map<String, dynamic> toBetterAuthUser() => {
    if (firstName?.isNotEmpty == true || lastName?.isNotEmpty == true)
      'name': <String, dynamic>{
        if (firstName?.isNotEmpty == true) 'firstName': firstName,
        if (lastName?.isNotEmpty == true) 'lastName': lastName,
      },
    if (email?.isNotEmpty == true) 'email': email,
  };

  @override
  bool operator ==(Object other) =>
      other is AppleInitialUser &&
      other.email == email &&
      other.firstName == firstName &&
      other.lastName == lastName;

  @override
  int get hashCode => Object.hash(email, firstName, lastName);
}

final class NativeAuthCredential {
  const new({
    required this.provider,
    required this.idToken,
    required this.nonce,
    this.appleUser,
  });

  final NativeAuthProvider provider;
  final String idToken;
  final String nonce;
  final AppleInitialUser? appleUser;

  Map<String, dynamic> toBetterAuthPayload() => {
    'provider': provider.name,
    'idToken': <String, dynamic>{
      'token': idToken,
      'nonce': nonce,
      if (appleUser case final user? when user.hasValue)
        'user': user.toBetterAuthUser(),
    },
  };
}

final class NativeAuthNonce {
  const new({required this.raw, required this.sha256});

  final String raw;
  final String sha256;
}

abstract interface class NativeAuthNonceGenerator {
  NativeAuthNonce generate();
}

final class CryptographicNonceGenerator implements NativeAuthNonceGenerator {
  new({Random? random}) : _random = random ?? Random.secure();

  final Random _random;

  @override
  NativeAuthNonce generate() {
    final bytes = List<int>.generate(32, (_) => _random.nextInt(256));
    final raw = base64Url.encode(bytes).replaceAll('=', '');
    return NativeAuthNonce(
      raw: raw,
      sha256: sha256.convert(utf8.encode(raw)).toString(),
    );
  }
}
