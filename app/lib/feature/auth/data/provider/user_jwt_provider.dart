import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_jwt_provider.g.dart';

@Riverpod(keepAlive: true)
Future<UserJwtProvider> userJwtService(Ref ref) async => UserJwtProvider(
  apiClient: await ref.watch(betterAuthApiClientProvider.future),
  now: DateTime.now,
);

final class UserJwtProvider {
  new({
    required BetterAuthApiClient apiClient,
    required DateTime Function() now,
  }) : _apiClient = apiClient,
       _now = now;

  final BetterAuthApiClient _apiClient;
  final DateTime Function() _now;
  String? _cachedJwt;
  DateTime? _expiresAt;
  Future<Result<String, AuthFailure>>? _refreshInFlight;

  Future<Result<String, AuthFailure>> getValidJwt({
    bool forceRefresh = false,
  }) {
    final cachedJwt = _cachedJwt;
    final expiresAt = _expiresAt;
    final refreshAt = _now().add(const Duration(seconds: 60));
    if (!forceRefresh &&
        cachedJwt != null &&
        expiresAt != null &&
        expiresAt.isAfter(refreshAt)) {
      return Future.value(Success(cachedJwt));
    }
    final inFlight = _refreshInFlight;
    if (inFlight != null) {
      return inFlight;
    }
    final request = _apiClient.fetchJwt().then((result) {
      switch (result) {
        case Success(:final value):
          final expiry = parseJwtExpiry(value);
          if (expiry == null) {
            return const Failure<String, AuthFailure>(
              AuthFailure(kind: AuthFailureKind.invalidResponse),
            );
          }
          _cachedJwt = value;
          _expiresAt = expiry;
          return Success<String, AuthFailure>(value);
        case Failure(:final exception, :final stackTrace):
          return Failure<String, AuthFailure>(exception, stackTrace);
      }
    });
    _refreshInFlight = request;
    return request.whenComplete(() {
      if (identical(_refreshInFlight, request)) {
        _refreshInFlight = null;
      }
    });
  }

  void clearJwt() {
    _cachedJwt = null;
    _expiresAt = null;
  }
}

DateTime? parseJwtExpiry(String token) {
  final segments = token.split('.');
  if (segments.length != 3) {
    return null;
  }
  try {
    final payload = switch (jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(segments[1]))),
    )) {
      final Map<String, dynamic> value => value,
      _ => null,
    };
    if (payload == null) {
      return null;
    }
    final expirationSeconds = switch (payload['exp']) {
      final int value => value,
      final double value => value.toInt(),
      _ => null,
    };
    return expirationSeconds == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            expirationSeconds * Duration.millisecondsPerSecond,
            isUtc: true,
          );
  } on FormatException {
    return null;
  }
}
