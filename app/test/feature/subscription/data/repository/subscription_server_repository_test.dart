import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_server_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Dio dio;
  late SubscriptionServerRepository repository;
  final requests = <RequestOptions>[];
  var payload = <String, dynamic>{};
  int? errorStatus;
  setUp(() {
    requests.clear();
    errorStatus = null;
    dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            requests.add(options);
            if (errorStatus case final status?) {
              handler.reject(
                DioException(
                  requestOptions: options,
                  response: Response<Map<String, dynamic>>(
                    requestOptions: options,
                    statusCode: status,
                  ),
                ),
              );
            } else {
              handler.resolve(
                Response<Map<String, dynamic>>(
                  requestOptions: options,
                  data: payload,
                ),
              );
            }
          },
        ),
      );
    repository = SubscriptionServerRepository(
      client: api.SubscriptionApiClient(dio),
    );
  });
  tearDown(() => dio.close());

  for (final status in ['ACTIVE', 'GRACE_PERIOD']) {
    test('$status maps verified expiry and renewal flag', () async {
      payload = {
        'status': status,
        'productId': 'pro',
        'expiresAt': '2099-01-01T00:00:00Z',
        'willRenew': false,
      };
      final actual = (await repository.fetch()).unwrap();
      expect(
        actual,
        SubscriptionStatus.active(
          productId: 'pro',
          expiresAt: DateTime.utc(2099),
          willRenew: false,
        ),
      );
      expect(requests.single.path, '/v2/subscription/me');
    });
  }
  test('expired cached server response never grants Pro', () async {
    payload = {
      'status': 'ACTIVE',
      'productId': 'pro',
      'expiresAt': '2000-01-01T00:00:00Z',
      'willRenew': false,
    };
    expect(
      (await repository.fetch()).unwrap(),
      const SubscriptionStatus.inactive(),
    );
  });
  test('sync posts no client-controlled identity or entitlement', () async {
    payload = {'status': 'INACTIVE'};
    expect(
      (await repository.fetch(synchronize: true)).unwrap(),
      const SubscriptionStatus.inactive(),
    );
    expect(requests.single.method, 'POST');
    expect(requests.single.path, '/v2/subscription/sync');
    expect(requests.single.data, isNull);
  });
  for (final entry in {
    401: SubscriptionApiFailure.authenticationRequired,
    409: SubscriptionApiFailure.pending,
    503: SubscriptionApiFailure.unavailable,
  }.entries) {
    test('maps HTTP ${entry.key} without pretending inactive', () async {
      errorStatus = entry.key;
      final result = await repository.fetch(synchronize: true);
      expect(
        result,
        isA<Failure<SubscriptionStatus, SubscriptionApiException>>().having(
          (result) => result.exception.reason,
          'reason',
          entry.value,
        ),
      );
    });
  }
  test('unknown status cannot become Free or Pro', () async {
    payload = {'status': 'UNKNOWN'};
    final result = await repository.fetch();
    expect(
      result,
      isA<Failure<SubscriptionStatus, SubscriptionApiException>>().having(
        (result) => result.exception.reason,
        'reason',
        SubscriptionApiFailure.invalidResponse,
      ),
    );
  });
}
