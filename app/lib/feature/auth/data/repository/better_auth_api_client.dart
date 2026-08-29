import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/auth_request_executor.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_cookie_jar_factory.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_token_manager.dart';
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
         createCookieJar:
             createCookieJar ?? const BetterAuthCookieJarFactory().create,
       ),
       _establishmentGate =
           establishmentGate ?? BetterAuthSessionEstablishmentGate() {
    _establishmentFactory = _BetterAuthSessionEstablishmentFactory(
      dio: _dio,
      sessionRepository: _sessionRepository,
      cookieStore: _cookieStore,
      establishmentGate: _establishmentGate,
    );
    _passkeyClient = _BetterAuthPasskeyClient(
      dio: _dio,
      establishmentFactory: _establishmentFactory,
    );
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
  late final _BetterAuthSessionEstablishmentFactory _establishmentFactory;
  late final _BetterAuthPasskeyClient _passkeyClient;

  Future<Result<BetterAuthSessionAcceptance, AuthFailure>> signInSocial({
    required String provider,
    required String idToken,
    String? nonce,
    Map<String, dynamic>? user,
  }) async {
    final establishmentResult = await _establishmentFactory.begin(
      endpoint: _BetterAuthSessionEndpoint.socialSignIn,
    );
    if (establishmentResult case Failure(
      :final exception,
      :final stackTrace,
    )) {
      return Failure(exception, stackTrace);
    }
    final establishment = establishmentResult.unwrap();
    final responseResult = await const AuthRequestExecutor().capture(
      () => _dio.post<void>(
        '/api/auth/sign-in/social',
        data: {
          'provider': provider,
          'idToken': {
            'token': idToken,
            if (nonce != null && nonce.isNotEmpty) 'nonce': nonce,
            if (user != null && user.isNotEmpty) 'user': user,
          },
        },
        options: establishment.jsonRequestOptions,
      ),
    );
    if (responseResult case Failure(:final exception, :final stackTrace)) {
      return establishment.rollbackWithFailure(
        failure: Failure(exception, stackTrace),
        didAttemptSessionSave: false,
      );
    }
    return establishment.commitAuthenticatedSession(
      response: responseResult.unwrap(),
    );
  }

  Future<Result<BetterAuthPasskeyRegistrationOperation, AuthFailure>>
  generatePasskeyRegistrationOptions() =>
      _passkeyClient.generateRegistrationOptions();

  Future<Result<void, AuthFailure>> verifyPasskeyRegistration({
    required BetterAuthPasskeyRegistrationOperation operation,
    required Map<String, dynamic> response,
  }) => operation.verify(response: response);

  Future<Result<BetterAuthPasskeyAuthenticationOperation, AuthFailure>>
  generatePasskeyAuthenticationOptions() =>
      _passkeyClient.generateAuthenticationOptions();

  Future<Result<BetterAuthSessionAcceptance, AuthFailure>>
  verifyPasskeyAuthentication({
    required BetterAuthPasskeyAuthenticationOperation operation,
    required Map<String, dynamic> response,
  }) => operation.verify(response: response);

  Future<Result<String, AuthFailure>> fetchJwt() {
    final sessionGeneration = _sessionRepository.generation;
    return const AuthRequestExecutor().capture(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/auth/token',
      );
      await const BetterAuthSessionTokenManager().persist(
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
    final remoteResult = await const AuthRequestExecutor().capture(
      () async {
        final response = await _dio.post<void>('/api/auth/sign-out');
        await const BetterAuthSessionTokenManager().persist(
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
    return const AuthRequestExecutor().capture(replacedCookieJar.deleteAll);
  }

  Future<Result<bool, AuthFailure>> getSession() {
    final sessionGeneration = _sessionRepository.generation;
    return const AuthRequestExecutor().capture(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/auth/get-session',
      );
      await const BetterAuthSessionTokenManager().persist(
        response: response,
        sessionRepository: _sessionRepository,
        expectedGeneration: sessionGeneration,
      );
      return response.data?['session'] is Map<String, dynamic>;
    });
  }
}

enum _BetterAuthSessionEndpoint {
  socialSignIn('/api/auth/sign-in/social'),
  passkeyRegistration('/api/auth/passkey/generate-register-options'),
  passkeyAuthentication('/api/auth/passkey/generate-authenticate-options');

  new(this.path);

  final String path;
}

enum _BetterAuthPasskeyCeremonyState {
  generated,
  verifying,
  committed,
  released,
}

final class _BetterAuthPasskeyCeremony {
  var _state = _BetterAuthPasskeyCeremonyState.generated;

  bool beginVerification({required bool isCurrent}) {
    if (_state != _BetterAuthPasskeyCeremonyState.generated || !isCurrent) {
      return false;
    }
    _state = _BetterAuthPasskeyCeremonyState.verifying;
    return true;
  }

  bool releaseGenerated() {
    if (_state != _BetterAuthPasskeyCeremonyState.generated) {
      return false;
    }
    _state = _BetterAuthPasskeyCeremonyState.released;
    return true;
  }

  void commit() {
    if (_state == _BetterAuthPasskeyCeremonyState.verifying) {
      _state = _BetterAuthPasskeyCeremonyState.committed;
    }
  }

  void release() {
    _state = _BetterAuthPasskeyCeremonyState.released;
  }
}

final class _BetterAuthPasskeyClient {
  const new({
    required Dio dio,
    required _BetterAuthSessionEstablishmentFactory establishmentFactory,
  }) : _dio = dio,
       _establishmentFactory = establishmentFactory;

  final Dio _dio;
  final _BetterAuthSessionEstablishmentFactory _establishmentFactory;

  Future<Result<BetterAuthPasskeyRegistrationOperation, AuthFailure>>
  generateRegistrationOptions() async {
    final establishmentResult = await _establishmentFactory.begin(
      endpoint: _BetterAuthSessionEndpoint.passkeyRegistration,
    );
    if (establishmentResult case Failure(
      :final exception,
      :final stackTrace,
    )) {
      return Failure(exception, stackTrace);
    }
    final establishment = establishmentResult.unwrap();
    final responseResult = await const AuthRequestExecutor().capture(
      () => _dio.get<Map<String, dynamic>>(
        '/api/auth/passkey/generate-register-options',
        options: establishment.jsonRequestOptions,
      ),
    );
    if (responseResult case Failure(:final exception, :final stackTrace)) {
      return establishment.abandonWithFailure(
        failure: Failure(exception, stackTrace),
      );
    }
    final options = responseResult.unwrap().data;
    if (options == null || options.isEmpty || !establishment.isCurrent) {
      return establishment.abandonWithFailure(
        failure: const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        ),
      );
    }
    return Success(
      BetterAuthPasskeyRegistrationOperation(
        options: options,
        dio: _dio,
        establishment: establishment,
      ),
    );
  }

  Future<Result<BetterAuthPasskeyAuthenticationOperation, AuthFailure>>
  generateAuthenticationOptions() async {
    final establishmentResult = await _establishmentFactory.begin(
      endpoint: _BetterAuthSessionEndpoint.passkeyAuthentication,
    );
    if (establishmentResult case Failure(
      :final exception,
      :final stackTrace,
    )) {
      return Failure(exception, stackTrace);
    }
    final establishment = establishmentResult.unwrap();
    final responseResult = await const AuthRequestExecutor().capture(
      () => _dio.get<Map<String, dynamic>>(
        '/api/auth/passkey/generate-authenticate-options',
        options: establishment.jsonRequestOptions,
      ),
    );
    if (responseResult case Failure(:final exception, :final stackTrace)) {
      return establishment.abandonWithFailure(
        failure: Failure(exception, stackTrace),
      );
    }
    final options = responseResult.unwrap().data;
    if (options == null || options.isEmpty || !establishment.isCurrent) {
      return establishment.abandonWithFailure(
        failure: const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        ),
      );
    }
    return Success(
      BetterAuthPasskeyAuthenticationOperation(
        options: options,
        dio: _dio,
        establishment: establishment,
      ),
    );
  }
}

final class BetterAuthPasskeyRegistrationOperation {
  new({
    required this.options,
    required Dio dio,
    required _BetterAuthSessionEstablishment establishment,
    _BetterAuthPasskeyRegistrationResponseParser? responseParser,
  }) : _dio = dio,
       _establishment = establishment,
       _responseParser =
           responseParser ??
           const _BetterAuthPasskeyRegistrationResponseParser();

  final Map<String, dynamic> options;
  final Dio _dio;
  final _BetterAuthSessionEstablishment _establishment;
  final _BetterAuthPasskeyRegistrationResponseParser _responseParser;
  final _ceremony = _BetterAuthPasskeyCeremony();

  Future<Result<void, AuthFailure>> verify({
    required Map<String, dynamic> response,
  }) async {
    if (!_ceremony.beginVerification(isCurrent: _establishment.isCurrent)) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    final responseResult = await const AuthRequestExecutor().capture(
      () => _dio.post<String>(
        '/api/auth/passkey/verify-registration',
        data: {'response': response},
        options: _establishment.plainTextRequestOptions,
      ),
    );
    if (responseResult case Failure(:final exception, :final stackTrace)) {
      _ceremony.release();
      return _establishment.rollbackWithFailure(
        failure: Failure(exception, stackTrace),
        didAttemptSessionSave: false,
      );
    }
    final httpResponse = responseResult.unwrap();
    if (!_responseParser.isValid(body: httpResponse.data)) {
      _ceremony.release();
      return _establishment.rollbackWithFailure(
        failure: const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        ),
        didAttemptSessionSave: false,
      );
    }
    final commitResult = await _establishment.commitRegistration(
      response: httpResponse,
    );
    switch (commitResult) {
      case Success():
        _ceremony.commit();
      case Failure():
        _ceremony.release();
    }
    return commitResult;
  }

  Future<Result<T, AuthFailure>> abandonWithFailure<T>({
    required Failure<T, AuthFailure> failure,
  }) async {
    if (!_ceremony.releaseGenerated()) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    return _establishment.abandonWithFailure(failure: failure);
  }
}

final class BetterAuthPasskeyAuthenticationOperation {
  new({
    required this.options,
    required Dio dio,
    required _BetterAuthSessionEstablishment establishment,
  }) : _dio = dio,
       _establishment = establishment;

  final Map<String, dynamic> options;
  final Dio _dio;
  final _BetterAuthSessionEstablishment _establishment;
  final _ceremony = _BetterAuthPasskeyCeremony();

  Future<Result<BetterAuthSessionAcceptance, AuthFailure>> verify({
    required Map<String, dynamic> response,
  }) async {
    if (!_ceremony.beginVerification(isCurrent: _establishment.isCurrent)) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    final responseResult = await const AuthRequestExecutor().capture(
      () => _dio.post<Map<String, dynamic>>(
        '/api/auth/passkey/verify-authentication',
        data: {'response': response},
        options: _establishment.jsonRequestOptions,
      ),
    );
    if (responseResult case Failure(:final exception, :final stackTrace)) {
      _ceremony.release();
      return _establishment.rollbackWithFailure(
        failure: Failure(exception, stackTrace),
        didAttemptSessionSave: false,
      );
    }
    final commitResult = await _establishment.commitAuthenticatedSession(
      response: responseResult.unwrap(),
    );
    switch (commitResult) {
      case Success():
        _ceremony.commit();
      case Failure():
        _ceremony.release();
    }
    return commitResult;
  }

  Future<Result<T, AuthFailure>> abandonWithFailure<T>({
    required Failure<T, AuthFailure> failure,
  }) async {
    if (!_ceremony.releaseGenerated()) {
      return const Failure(
        AuthFailure(kind: AuthFailureKind.invalidResponse),
      );
    }
    return _establishment.abandonWithFailure(failure: failure);
  }
}

final class _BetterAuthPasskeyRegistrationResponseParser {
  const new();

  bool isValid({required String? body}) {
    if (body == null || body.isEmpty) {
      return false;
    }
    try {
      return switch (jsonDecode(body)) {
        {
          'id': final String id,
          'credentialID': final String credentialId,
          'userId': final String userId,
        } =>
          id.isNotEmpty && credentialId.isNotEmpty && userId.isNotEmpty,
        _ => false,
      };
    } on FormatException {
      return false;
    }
  }
}

final class _BetterAuthSessionEstablishmentFactory {
  const new({
    required Dio dio,
    required BetterAuthSessionRepository sessionRepository,
    required BetterAuthCookieStore cookieStore,
    required BetterAuthSessionEstablishmentGate establishmentGate,
  }) : _dio = dio,
       _sessionRepository = sessionRepository,
       _cookieStore = cookieStore,
       _establishmentGate = establishmentGate;

  final Dio _dio;
  final BetterAuthSessionRepository _sessionRepository;
  final BetterAuthCookieStore _cookieStore;
  final BetterAuthSessionEstablishmentGate _establishmentGate;

  Future<Result<_BetterAuthSessionEstablishment, AuthFailure>> begin({
    required _BetterAuthSessionEndpoint endpoint,
  }) async {
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
    final transactionResult = await const AuthRequestExecutor().capture(
      () => _cookieStore.beginTransaction(
        uri: Uri.parse(_dio.options.baseUrl).resolve(endpoint.path),
      ),
    );
    if (transactionResult case Failure(:final exception, :final stackTrace)) {
      _establishmentGate.complete(establishmentId: establishmentId);
      return Failure(exception, stackTrace);
    }
    return Success(
      _BetterAuthSessionEstablishment(
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
}

final class _BetterAuthSessionEstablishment {
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

  Options get jsonRequestOptions => Options(
    extra: {
      BetterAuthCookieStore.transactionExtraKey: cookieTransaction,
    },
  );

  Options get plainTextRequestOptions => Options(
    responseType: ResponseType.plain,
    extra: {
      BetterAuthCookieStore.transactionExtraKey: cookieTransaction,
    },
  );

  Future<Result<void, AuthFailure>> commitRegistration({
    required Response<String> response,
  }) async {
    if (!isCurrent) {
      return rollback(
        failure: const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        ),
        didAttemptSessionSave: false,
      );
    }
    var didAttemptSessionSave = false;
    final commitResult = await const AuthRequestExecutor().capture(() async {
      final tokenHeaders = response.headers.map['set-auth-token'];
      final token = switch (tokenHeaders) {
        null => null,
        [final String value] => value,
        _ => throw const AuthFailure(
          kind: AuthFailureKind.invalidResponse,
        ),
      };
      if (token != null) {
        if (!const BetterAuthSessionTokenManager().isSafe(token)) {
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
    if (commitResult is Success<void, AuthFailure>) {
      establishmentGate.complete(establishmentId: establishmentId);
      return commitResult;
    }
    return rollback(
      failure: commitResult,
      didAttemptSessionSave: didAttemptSessionSave,
    );
  }

  Future<Result<BetterAuthSessionAcceptance, AuthFailure>>
  commitAuthenticatedSession<T>({required Response<T> response}) async {
    if (!isCurrent) {
      return rollbackWithFailure(
        failure: const Failure(
          AuthFailure(kind: AuthFailureKind.invalidResponse),
        ),
        didAttemptSessionSave: false,
      );
    }
    var didAttemptSessionSave = false;
    final commitResult = await const AuthRequestExecutor().capture(() async {
      final token = switch (response.headers.map['set-auth-token']) {
        [final String value]
            when const BetterAuthSessionTokenManager().isSafe(value) =>
          value,
        _ => throw const AuthFailure(
          kind: AuthFailureKind.invalidResponse,
        ),
      };
      didAttemptSessionSave = true;
      final saveResult = await sessionRepository.saveSessionToken(
        token: token,
        expectedGeneration: sessionGeneration,
      );
      if (saveResult case Failure(:final exception)) {
        throw exception;
      }
      if (!isCurrent || !cookieStore.commit(transaction: cookieTransaction)) {
        throw const AuthFailure(kind: AuthFailureKind.invalidResponse);
      }
      return BetterAuthSessionAcceptance(
        establishmentGate: establishmentGate,
        establishmentId: establishmentId,
      );
    });
    return switch (commitResult) {
      Success() => commitResult,
      Failure(:final exception, :final stackTrace) => rollbackWithFailure(
        failure: Failure(exception, stackTrace),
        didAttemptSessionSave: didAttemptSessionSave,
      ),
    };
  }

  Future<Result<void, AuthFailure>> abandon() async {
    if (!establishmentGate.isCurrent(establishmentId: establishmentId)) {
      return const Success(null);
    }
    final result = await const AuthRequestExecutor().capture(
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

  Future<Result<T, AuthFailure>> rollbackWithFailure<T>({
    required Failure<T, AuthFailure> failure,
    required bool didAttemptSessionSave,
  }) async {
    final rollbackResult = await rollback(
      failure: Failure(failure.exception, failure.stackTrace),
      didAttemptSessionSave: didAttemptSessionSave,
    );
    return switch (rollbackResult) {
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
    final cookieRollbackResult = await const AuthRequestExecutor().capture(
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

final class BetterAuthSessionAcceptance {
  new({
    required BetterAuthSessionEstablishmentGate establishmentGate,
    required int establishmentId,
  }) : _establishmentGate = establishmentGate,
       _establishmentId = establishmentId;

  final BetterAuthSessionEstablishmentGate _establishmentGate;
  final int _establishmentId;
  var _released = false;

  void release() {
    if (_released) {
      return;
    }
    _released = true;
    _establishmentGate.complete(establishmentId: _establishmentId);
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
        if (value != null &&
            const BetterAuthSessionTokenManager().isSafe(value)) {
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
