import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'better_auth_api_client.g.dart';

@Riverpod(keepAlive: true)
Future<BetterAuthApiClient> betterAuthApiClient(Ref ref) async {
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final sessionRepository = await ref.watch(
    betterAuthSessionRepositoryProvider.future,
  );
  return BetterAuthApiClient(
    dio: Dio(
      DioBaseOptionsFactory.build(baseUrl: telegramUrl.restApiUrl),
    ),
    sessionRepository: sessionRepository,
    cookieJar: CookieJar(),
  );
}

final class BetterAuthApiClient {
  new({
    required Dio dio,
    required BetterAuthSessionRepository sessionRepository,
    required CookieJar cookieJar,
    CookieJar Function()? createCookieJar,
  }) : _dio = dio,
       _sessionRepository = sessionRepository,
       _cookieStore = BetterAuthCookieStore(
         initialCookieJar: cookieJar,
         createCookieJar: createCookieJar ?? createInMemoryCookieJar,
       ) {
    _dio.interceptors.addAll([
      BetterAuthCookieInterceptor(
        cookieStore: _cookieStore,
        sessionRepository: sessionRepository,
      ),
      BetterAuthSessionInterceptor(sessionRepository: sessionRepository),
    ]);
  }

  final Dio _dio;
  final BetterAuthSessionRepository _sessionRepository;
  final BetterAuthCookieStore _cookieStore;

  Future<Result<void, AuthFailure>> signInSocial({
    required String provider,
    required String idToken,
    String? nonce,
    Map<String, dynamic>? user,
  }) async {
    final sessionGeneration = _sessionRepository.generation;
    final existingSessionResult = await _sessionRepository.readSessionToken();
    if (existingSessionResult case Failure(
      :final exception,
      :final stackTrace,
    )) {
      return Failure(exception, stackTrace);
    }
    final existingSessionToken = existingSessionResult.unwrap();
    final transactionResult = await captureAuthRequest(
      () => _cookieStore.beginTransaction(
        uri: Uri.parse(
          _dio.options.baseUrl,
        ).resolve('/api/auth/sign-in/social'),
      ),
    );
    if (transactionResult case Failure(:final exception, :final stackTrace)) {
      return Failure(exception, stackTrace);
    }
    final cookieTransaction = transactionResult.unwrap();
    var didAttemptSessionSave = false;
    final requestResult = await captureAuthRequest(() async {
      final response = await _dio.post<void>(
        '/api/auth/sign-in/social',
        data: <String, dynamic>{
          'provider': provider,
          'idToken': <String, dynamic>{
            'token': idToken,
            if (nonce != null && nonce.isNotEmpty) 'nonce': nonce,
            if (user != null && user.isNotEmpty) 'user': user,
          },
        },
        options: Options(
          extra: {
            BetterAuthCookieStore.transactionExtraKey: cookieTransaction,
          },
        ),
      );
      final tokenHeaders = response.headers.map['set-auth-token'];
      if (tokenHeaders == null || tokenHeaders.length != 1) {
        throw const AuthFailure(kind: AuthFailureKind.invalidResponse);
      }
      final token = tokenHeaders.single;
      if (!isSafeBetterAuthSessionToken(token)) {
        throw const AuthFailure(kind: AuthFailureKind.invalidResponse);
      }
      didAttemptSessionSave = true;
      final saveResult = await _sessionRepository.saveSessionToken(
        token: token,
        expectedGeneration: sessionGeneration,
      );
      if (saveResult case Failure(:final exception)) {
        throw exception;
      }
      if (_sessionRepository.generation != sessionGeneration) {
        throw const AuthFailure(kind: AuthFailureKind.invalidResponse);
      }
      if (!_cookieStore.commit(transaction: cookieTransaction)) {
        throw const AuthFailure(kind: AuthFailureKind.invalidResponse);
      }
    });
    if (requestResult is Success<void, AuthFailure>) {
      return requestResult;
    }

    final cookieRollbackResult = await captureAuthRequest(
      cookieTransaction.transactionSnapshot.cookieJar.deleteAll,
    );
    Result<void, AuthFailure> sessionRollbackResult =
        const Success<void, AuthFailure>(null);
    if (didAttemptSessionSave &&
        _sessionRepository.generation == sessionGeneration) {
      sessionRollbackResult = existingSessionToken == null
          ? await _sessionRepository.clearSession()
          : await _sessionRepository.saveSessionToken(
              token: existingSessionToken,
              expectedGeneration: sessionGeneration,
            );
    }
    return switch ((sessionRollbackResult, cookieRollbackResult)) {
      (Failure(:final exception, :final stackTrace), _) => Failure(
        exception,
        stackTrace,
      ),
      (_, Failure(:final exception, :final stackTrace)) => Failure(
        exception,
        stackTrace,
      ),
      _ => requestResult,
    };
  }

  Future<Result<String, AuthFailure>> fetchJwt() {
    final sessionGeneration = _sessionRepository.generation;
    return captureAuthRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/auth/token',
      );
      await persistBetterAuthSessionToken(
        response: response,
        sessionRepository: _sessionRepository,
        expectedGeneration: sessionGeneration,
      );
      return switch (response.data?['token']) {
        final String token when token.isNotEmpty => token,
        _ => throw const AuthFailure(kind: AuthFailureKind.invalidResponse),
      };
    });
  }

  Future<Result<void, AuthFailure>> signOut() async {
    final sessionGeneration = _sessionRepository.generation;
    final remoteResult = await captureAuthRequest(
      () async {
        final response = await _dio.post<void>('/api/auth/sign-out');
        await persistBetterAuthSessionToken(
          response: response,
          sessionRepository: _sessionRepository,
          expectedGeneration: sessionGeneration,
        );
      },
    );
    final cookieResult = await clearCookies();
    return switch (remoteResult) {
      Failure(:final exception, :final stackTrace) => Failure(
        exception,
        stackTrace,
      ),
      Success() => cookieResult,
    };
  }

  Future<Result<void, AuthFailure>> clearCookies() {
    final replacedCookieJar = _cookieStore.replace();
    return captureAuthRequest(replacedCookieJar.deleteAll);
  }

  Future<Result<bool, AuthFailure>> getSession() {
    final sessionGeneration = _sessionRepository.generation;
    return captureAuthRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/auth/get-session',
      );
      await persistBetterAuthSessionToken(
        response: response,
        sessionRepository: _sessionRepository,
        expectedGeneration: sessionGeneration,
      );
      return response.data?['session'] is Map<String, dynamic>;
    });
  }
}

final class BetterAuthCookieStore {
  static const transactionExtraKey = 'better_auth_cookie_transaction';

  new({
    required CookieJar initialCookieJar,
    required CookieJar Function() createCookieJar,
  }) : _createCookieJar = createCookieJar,
       _snapshot = BetterAuthCookieSnapshot(cookieJar: initialCookieJar);

  final CookieJar Function() _createCookieJar;
  BetterAuthCookieSnapshot _snapshot;

  BetterAuthCookieSnapshot get snapshot => _snapshot;

  bool isCurrent({required BetterAuthCookieSnapshot snapshot}) =>
      identical(_snapshot, snapshot);

  Future<BetterAuthCookieTransaction> beginTransaction({
    required Uri uri,
  }) async {
    final baseSnapshot = _snapshot;
    final transactionSnapshot = BetterAuthCookieSnapshot(
      cookieJar: _createCookieJar(),
    );
    final cookies = await baseSnapshot.cookieJar.loadForRequest(uri);
    await transactionSnapshot.cookieJar.saveFromResponse(uri, cookies);
    return BetterAuthCookieTransaction(
      baseSnapshot: baseSnapshot,
      transactionSnapshot: transactionSnapshot,
    );
  }

  bool canCommit({required BetterAuthCookieTransaction transaction}) =>
      identical(_snapshot, transaction.baseSnapshot);

  bool commit({required BetterAuthCookieTransaction transaction}) {
    if (!canCommit(transaction: transaction)) {
      return false;
    }
    _snapshot = transaction.transactionSnapshot;
    return true;
  }

  CookieJar replace() {
    final replacedCookieJar = _snapshot.cookieJar;
    _snapshot = BetterAuthCookieSnapshot(cookieJar: _createCookieJar());
    return replacedCookieJar;
  }
}

final class BetterAuthCookieTransaction {
  const new({
    required this.baseSnapshot,
    required this.transactionSnapshot,
  });

  final BetterAuthCookieSnapshot baseSnapshot;
  final BetterAuthCookieSnapshot transactionSnapshot;
}

final class BetterAuthCookieSnapshot {
  const new({required this.cookieJar});

  final CookieJar cookieJar;
}

final class BetterAuthCookieRequestContext {
  const new({
    required this.cookieManager,
    required this.cookieSnapshot,
    required this.cookieTransaction,
    required this.sessionGeneration,
  });

  final CookieManager cookieManager;
  final BetterAuthCookieSnapshot cookieSnapshot;
  final BetterAuthCookieTransaction? cookieTransaction;
  final int sessionGeneration;
}

final class BetterAuthCookieInterceptor extends Interceptor {
  new({
    required this.cookieStore,
    required this.sessionRepository,
  });

  final BetterAuthCookieStore cookieStore;
  final BetterAuthSessionRepository sessionRepository;
  final Expando<BetterAuthCookieRequestContext> _requestContexts = Expando();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final transaction =
        switch (options.extra[BetterAuthCookieStore.transactionExtraKey]) {
          final BetterAuthCookieTransaction value => value,
          _ => null,
        };
    final snapshot = transaction?.transactionSnapshot ?? cookieStore.snapshot;
    final cookieManager = CookieManager(snapshot.cookieJar);
    _requestContexts[options] = BetterAuthCookieRequestContext(
      cookieManager: cookieManager,
      cookieSnapshot: snapshot,
      cookieTransaction: transaction,
      sessionGeneration: sessionRepository.generation,
    );
    return cookieManager.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final context = _requestContexts[response.requestOptions];
    final transaction = context?.cookieTransaction;
    final isCurrent =
        context != null &&
        (transaction == null
            ? cookieStore.isCurrent(snapshot: context.cookieSnapshot)
            : cookieStore.canCommit(transaction: transaction));
    if (context == null ||
        context.sessionGeneration != sessionRepository.generation ||
        !isCurrent) {
      handler.next(response);
      return Future.value();
    }
    return context.cookieManager.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    final context = _requestContexts[error.requestOptions];
    final transaction = context?.cookieTransaction;
    final isCurrent =
        context != null &&
        (transaction == null
            ? cookieStore.isCurrent(snapshot: context.cookieSnapshot)
            : cookieStore.canCommit(transaction: transaction));
    if (context == null ||
        context.sessionGeneration != sessionRepository.generation ||
        !isCurrent) {
      handler.next(error);
      return Future.value();
    }
    return context.cookieManager.onError(error, handler);
  }
}

final class BetterAuthSessionInterceptor extends Interceptor {
  new({required this.sessionRepository});

  final BetterAuthSessionRepository sessionRepository;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokenResult = await sessionRepository.readSessionToken();
    switch (tokenResult) {
      case Success(:final value):
        if (value != null && isSafeBetterAuthSessionToken(value)) {
          options.headers['Authorization'] = 'Bearer $value';
        }
        handler.next(options);
      case Failure(:final exception, :final stackTrace):
        handler.reject(
          DioException(
            requestOptions: options,
            error: exception,
            stackTrace: stackTrace,
          ),
        );
    }
  }
}

CookieJar createInMemoryCookieJar() => CookieJar();

Future<void> persistBetterAuthSessionToken<T>({
  required Response<T> response,
  required BetterAuthSessionRepository sessionRepository,
  required int expectedGeneration,
}) async {
  final tokenHeaders = response.headers.map['set-auth-token'];
  if (tokenHeaders == null || tokenHeaders.length != 1) {
    return;
  }
  final token = tokenHeaders.single;
  if (isSafeBetterAuthSessionToken(token)) {
    final saveResult = await sessionRepository.saveSessionToken(
      token: token,
      expectedGeneration: expectedGeneration,
    );
    if (saveResult case Failure(:final exception)) {
      throw exception;
    }
  }
}

bool isSafeBetterAuthSessionToken(String token) {
  if (token.isEmpty || token.trim() != token) {
    return false;
  }
  return !token.codeUnits.any((unit) => unit < 0x21 || unit == 0x7f);
}

Future<Result<T, AuthFailure>> captureAuthRequest<T>(
  FutureOr<T> Function() request,
) async {
  try {
    return Success(await request());
  } on AuthFailure catch (failure, stackTrace) {
    return Failure(failure, stackTrace);
  } on DioException catch (exception, stackTrace) {
    return Failure(authFailureFromDio(exception), stackTrace);
  } on FormatException catch (_, stackTrace) {
    return Failure(
      const AuthFailure(kind: AuthFailureKind.invalidResponse),
      stackTrace,
    );
  } on Exception catch (_, stackTrace) {
    return Failure(
      const AuthFailure(kind: AuthFailureKind.unknown),
      stackTrace,
    );
  }
}

AuthFailure authFailureFromDio(DioException exception) {
  if (exception.error case final AuthFailure failure) {
    return failure;
  }
  final statusCode = exception.response?.statusCode;
  if (statusCode == 401) {
    return const AuthFailure(
      kind: AuthFailureKind.unauthorized,
      statusCode: 401,
    );
  }
  if (statusCode == 429) {
    return const AuthFailure(
      kind: AuthFailureKind.rateLimited,
      statusCode: 429,
    );
  }
  if (statusCode != null && statusCode >= 500) {
    return AuthFailure(kind: AuthFailureKind.server, statusCode: statusCode);
  }
  if (exception.type
      case DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout) {
    return AuthFailure(kind: AuthFailureKind.timeout, statusCode: statusCode);
  }
  if (exception.type case DioExceptionType.connectionError) {
    return AuthFailure(kind: AuthFailureKind.network, statusCode: statusCode);
  }
  return AuthFailure(kind: AuthFailureKind.unknown, statusCode: statusCode);
}
