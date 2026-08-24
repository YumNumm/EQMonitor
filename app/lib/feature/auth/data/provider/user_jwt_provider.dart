import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_jwt_provider.g.dart';

@Riverpod(keepAlive: true)
Future<UserJwtProvider> userJwtService(Ref ref) async {
  final provider = UserJwtProvider(
    apiClient: await ref.watch(betterAuthApiClientProvider.future),
    now: DateTime.now,
  );
  ref.onDispose(provider.dispose);
  return provider;
}

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
  var _generation = 0;
  var _isDisposed = false;

  Future<Result<String, AuthFailure>> getValidJwt({
    bool forceRefresh = false,
  }) {
    if (_isDisposed) {
      return Future.value(
        const Failure(
          AuthFailure(kind: AuthFailureKind.unauthorized),
        ),
      );
    }
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
    final requestGeneration = _generation;
    final request = _apiClient.fetchJwt().then((result) {
      if (_isDisposed || requestGeneration != _generation) {
        return const Failure<String, AuthFailure>(
          AuthFailure(kind: AuthFailureKind.unauthorized),
        );
      }
      switch (result) {
        case Success(:final value):
          final expiry = parseJwtExpiry(value);
          final refreshAt = _now().add(const Duration(seconds: 60));
          if (expiry == null || !expiry.isAfter(refreshAt)) {
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
    _generation++;
    _cachedJwt = null;
    _expiresAt = null;
    _refreshInFlight = null;
  }

  void dispose() {
    _isDisposed = true;
    clearJwt();
  }
}

DateTime? parseJwtExpiry(String token) {
  final segments = token.split('.');
  if (segments.length != 3 ||
      segments.any(
        (segment) => segment.isEmpty || !_jwtSegmentPattern.hasMatch(segment),
      )) {
    return null;
  }
  try {
    final header = jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(segments[0]))),
    );
    if (header is! Map<String, dynamic>) {
      return null;
    }
    final payload = switch (jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(segments[1]))),
    )) {
      final Map<String, dynamic> value => value,
      _ => null,
    };
    if (payload == null) {
      return null;
    }
    final signature = base64Url.decode(base64Url.normalize(segments[2]));
    final expirationSeconds = payload['exp'];
    if (signature.isEmpty ||
        expirationSeconds is! num ||
        !expirationSeconds.isFinite) {
      return null;
    }
    final milliseconds = expirationSeconds * Duration.millisecondsPerSecond;
    if (!milliseconds.isFinite ||
        milliseconds < -8640000000000000 ||
        milliseconds > 8640000000000000) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(
      milliseconds.round(),
      isUtc: true,
    );
  } on FormatException {
    return null;
  } on RangeError {
    return null;
  }
}

final _jwtSegmentPattern = RegExp(r'^[A-Za-z0-9_-]+$');
