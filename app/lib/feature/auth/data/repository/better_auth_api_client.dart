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
    BetterAuthSessionEstablishmentGate? establishmentGate,
  }) : _dio = dio,
       _sessionRepository = sessionRepository,
       _cookieStore = BetterAuthCookieStore(
         initialCookieJar: cookieJar,
         createCookieJar: createCookieJar ?? createInMemoryCookieJar,
       ),
       _establishmentGate =
           establishmentGate ?? BetterAuthSessionEstablishmentGate() {
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
  final BetterAuthSessionEstablishmentGate _establishmentGate;

  Future<Result<void, AuthFailure>> signInSocial({
    required String provider,
    required String idToken,
    String? nonce,
    Map<String, dynamic>? user,
  }) async {
    final establishmentResult = await beginSessionEstablishment(
      path: '/api/auth/sign-in/social',
    );
    if (establishmentResult case Failure(
      :final exception,
      :final stackTrace,
    )) {
      return Failure(exception, stackTrace);
    }
    return establishmentResult.unwrap().verify(
      tokenPolicy: BetterAuthSessionTokenPolicy.required,
      request: (options) => _dio.post<void>(
        '/api/auth/sign-in/social',
        data: {
          'provider': provider,
          'idToken': {
            'token': idToken,
            if (nonce != null && nonce.isNotEmpty) 'nonce': nonce,
            if (user != null && user.isNotEmpty) 'user': user,
          },
        },
        options: options,
      ),
    );
  }

  Future<Result<BetterAuthPasskeyOperation, AuthFailure>>
  generatePasskeyRegistrationOptions() => generatePasskeyOptions(
    path: '/api/auth/passkey/generate-register-options',
  );

  Future<Result<void, AuthFailure>> verifyPasskeyRegistration({
    required BetterAuthPasskeyOperation operation,
    required Map<String, dynamic> response,
  }) => operation.establishment.verify(
    tokenPolicy: BetterAuthSessionTokenPolicy.optional,
    request: (options) => _dio.post<Map<String, dynamic>>(
      '/api/auth/passkey/verify-registration',
      data: {'response': response},
      options: options,
    ),
  );

  Future<Result<BetterAuthPasskeyOperation, AuthFailure>>
  generatePasskeyAuthenticationOptions() => generatePasskeyOptions(
    path: '/api/auth/passkey/generate-authenticate-options',
  );

  Future<Result<void, AuthFailure>> verifyPasskeyAuthentication({
    required BetterAuthPasskeyOperation operation,
    required Map<String, dynamic> response,
  }) => operation.establishment.verify(
    tokenPolicy: BetterAuthSessionTokenPolicy.required,
    request: (options) => _dio.post<Map<String, dynamic>>(
      '/api/auth/passkey/verify-authentication',
      data: {'response': response},
      options: options,
    ),
  );

  Future<Result<BetterAuthPasskeyOperation, AuthFailure>>
  generatePasskeyOptions({required String path}) async {
    final establishmentResult = await beginSessionEstablishment(path: path);
    if (establishmentResult case Failure(
      :final exception,
      :final stackTrace,
    )) {
      return Failure(exception, stackTrace);
    }
    final establishment = establishmentResult.unwrap();
    final responseResult = await captureAuthRequest(
      () => _dio.get<Map<String, dynamic>>(
        path,
        options: establishment.requestOptions,
      ),
    );
    if (responseResult case Failure(:final exception, :final stackTrace)) {
      return establishment.abandonWithFailure(
        failure: Failure(exception, stackTrace),
      );
    }
    final response = responseResult.unwrap();
    final options = response.data;
    if (options == null || options.isEmpty || !establishment.isCurrent) {
      return establishment.abandonWithFailure(
        failure: const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        ),
      );
    }
    return Success(
      BetterAuthPasskeyOperation(
        options: options,
        establishment: establishment,
      ),
    );
  }

  Future<Result<BetterAuthSessionEstablishment, AuthFailure>>
  beginSessionEstablishment({required String path}) async {
    final establishmentId = _establishmentGate.tryBegin();
    if (establishmentId == null) {
      return const Failure(AuthFailure(kind: AuthFailureKind.busy));
    }
    final sessionGeneration = _sessionRepository.generation;
    final existingSessionResult = await _sessionRepository.readSessionToken();
    if (existingSessionResult case Failure(
      :final exception,
      :final stackTrace,
    )) {
      _establishmentGate.complete(establishmentId: establishmentId);
      return Failure(exception, stackTrace);
    }
    final transactionResult = await captureAuthRequest(
      () => _cookieStore.beginTransaction(
        uri: Uri.parse(_dio.options.baseUrl).resolve(path),
      ),
    );
    if (transactionResult case Failure(:final exception, :final stackTrace)) {
      _establishmentGate.complete(establishmentId: establishmentId);
      return Failure(exception, stackTrace);
    }
    return Success(
      BetterAuthSessionEstablishment(
        sessionRepository: _sessionRepository,
        cookieStore: _cookieStore,
        cookieTransaction: transactionResult.unwrap(),
        sessionGeneration: sessionGeneration,
        existingSessionToken: existingSessionResult.unwrap(),
        establishmentGate: _establishmentGate,
        establishmentId: establishmentId,
      ),
    );
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

enum BetterAuthSessionTokenPolicy { required, optional }

final class BetterAuthPasskeyOperation {
  const new({
    required this.options,
    required this.establishment,
  });

  final Map<String, dynamic> options;
  final BetterAuthSessionEstablishment establishment;
}

final class BetterAuthSessionEstablishment {
  const new({
    required this.sessionRepository,
    required this.cookieStore,
    required this.cookieTransaction,
    required this.sessionGeneration,
    required this.existingSessionToken,
    required this.establishmentGate,
    required this.establishmentId,
  });

  final BetterAuthSessionRepository sessionRepository;
  final BetterAuthCookieStore cookieStore;
  final BetterAuthCookieTransaction cookieTransaction;
  final int sessionGeneration;
  final String? existingSessionToken;
  final BetterAuthSessionEstablishmentGate establishmentGate;
  final int establishmentId;

  bool get isCurrent =>
      sessionRepository.generation == sessionGeneration &&
      cookieStore.canCommit(transaction: cookieTransaction) &&
      establishmentGate.isCurrent(establishmentId: establishmentId);

  Options get requestOptions => Options(
    extra: {
      BetterAuthCookieStore.transactionExtraKey: cookieTransaction,
    },
  );

  Future<Result<void, AuthFailure>> verify<T>({
    required BetterAuthSessionTokenPolicy tokenPolicy,
    required Future<Response<T>> Function(Options options) request,
  }) async {
    if (!establishmentGate.isCurrent(establishmentId: establishmentId)) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    if (!isCurrent) {
      return await rollback(
        failure: const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        ),
        didAttemptSessionSave: false,
      );
    }
    var didAttemptSessionSave = false;
    final requestResult = await captureAuthRequest(() async {
      final response = await request(requestOptions);
      final tokenHeaders = response.headers.map['set-auth-token'];
      final token = switch ((tokenPolicy, tokenHeaders)) {
        (BetterAuthSessionTokenPolicy.required, [final String value]) => value,
        (BetterAuthSessionTokenPolicy.optional, null) => null,
        (BetterAuthSessionTokenPolicy.optional, [final String value]) => value,
        _ => throw const AuthFailure(
          kind: AuthFailureKind.invalidResponse,
        ),
      };
      if (token != null) {
        if (!isSafeBetterAuthSessionToken(token)) {
          throw const AuthFailure(kind: AuthFailureKind.invalidResponse);
        }
        didAttemptSessionSave = true;
        final saveResult = await sessionRepository.saveSessionToken(
          token: token,
          expectedGeneration: sessionGeneration,
        );
        if (saveResult case Failure(:final exception)) {
          throw exception;
        }
      }
      if (!isCurrent || !cookieStore.commit(transaction: cookieTransaction)) {
        throw const AuthFailure(kind: AuthFailureKind.invalidResponse);
      }
    });
    if (requestResult is Success<void, AuthFailure>) {
      establishmentGate.complete(establishmentId: establishmentId);
      return requestResult;
    }
    return rollback(
      failure: requestResult,
      didAttemptSessionSave: didAttemptSessionSave,
    );
  }

  Future<Result<void, AuthFailure>> abandon() async {
    if (!establishmentGate.isCurrent(establishmentId: establishmentId)) {
      return const Success(null);
    }
    final result = await captureAuthRequest(
      cookieTransaction.transactionSnapshot.cookieJar.deleteAll,
    );
    establishmentGate.complete(establishmentId: establishmentId);
    return result;
  }

  Future<Result<T, AuthFailure>> abandonWithFailure<T>({
    required Failure<T, AuthFailure> failure,
  }) async {
    final abandonmentResult = await abandon();
    return switch (abandonmentResult) {
      Failure(:final exception, :final stackTrace) => Failure(
        exception,
        stackTrace,
      ),
      Success() => failure,
    };
  }

  Future<Result<void, AuthFailure>> rollback({
    required Result<void, AuthFailure> failure,
    required bool didAttemptSessionSave,
  }) async {
    if (!establishmentGate.isCurrent(establishmentId: establishmentId)) {
      return failure;
    }
    final cookieRollbackResult = await captureAuthRequest(
      cookieTransaction.transactionSnapshot.cookieJar.deleteAll,
    );
    Result<void, AuthFailure> sessionRollbackResult =
        const Success<void, AuthFailure>(null);
    if (didAttemptSessionSave &&
        sessionRepository.generation == sessionGeneration) {
      final tokenToRestore = existingSessionToken;
      sessionRollbackResult = tokenToRestore == null
          ? await sessionRepository.clearSession()
          : await sessionRepository.saveSessionToken(
              token: tokenToRestore,
              expectedGeneration: sessionGeneration,
            );
    }
    establishmentGate.complete(establishmentId: establishmentId);
    return switch ((sessionRollbackResult, cookieRollbackResult)) {
      (Failure(:final exception, :final stackTrace), _) => Failure(
        exception,
        stackTrace,
      ),
      (_, Failure(:final exception, :final stackTrace)) => Failure(
        exception,
        stackTrace,
      ),
      _ => failure,
    };
  }
}

final class BetterAuthSessionEstablishmentGate {
  var _nextEstablishmentId = 0;
  int? _activeEstablishmentId;

  int? tryBegin() {
    if (_activeEstablishmentId != null) {
      return null;
    }
    _nextEstablishmentId++;
    _activeEstablishmentId = _nextEstablishmentId;
    return _activeEstablishmentId;
  }

  bool isCurrent({required int establishmentId}) =>
      _activeEstablishmentId == establishmentId;

  void complete({required int establishmentId}) {
    if (_activeEstablishmentId == establishmentId) {
      _activeEstablishmentId = null;
    }
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
  if (statusCode != null && statusCode >= 400 && statusCode < 500) {
    return AuthFailure(
      kind: AuthFailureKind.invalidResponse,
      statusCode: statusCode,
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
