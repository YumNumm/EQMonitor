import 'package:dio/dio.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

void main() {
  for (final status in ['ACTIVE', 'GRACE_PERIOD']) {
    test('$status parses the active projection', () {
      final response = GetV2SubscriptionMeResponseUnion.fromJson({
        'status': status,
        'productId': 'eqmonitor_pro_monthly',
        'expiresAt': '2026-10-01T00:00:00Z',
        'willRenew': true,
      });
      expect(
        response,
        isA<GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse>()
            .having((value) => value.status.json, 'status', status)
            .having(
              (value) => value.productId,
              'productId',
              'eqmonitor_pro_monthly',
            )
            .having(
              (value) => value.expiresAt,
              'expiresAt',
              DateTime.utc(2026, 10),
            )
            .having((value) => value.willRenew, 'willRenew', isTrue),
      );
    });
  }

  test('INACTIVE parses without active fields', () {
    expect(
      GetV2SubscriptionMeResponseUnion.fromJson({'status': 'INACTIVE'}),
      isA<GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse>(),
    );
  });

  test('active projection supports a null expiration', () {
    expect(
      GetV2SubscriptionMeResponseUnion.fromJson({
        'status': 'ACTIVE',
        'productId': 'eqmonitor_pro_monthly',
        'expiresAt': null,
        'willRenew': false,
      }),
      isA<GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse>().having(
        (value) => value.expiresAt,
        'expiresAt',
        isNull,
      ),
    );
  });

  for (final json in <Map<String, dynamic>>[
    {'status': 'UNKNOWN'},
    {'status': 1},
    {},
  ]) {
    test('rejects invalid status: $json', () {
      expect(
        () => GetV2SubscriptionMeResponseUnion.fromJson(json),
        throwsArgumentError,
      );
    });
  }

  for (final fields in <Map<String, dynamic>>[
    {'expiresAt': null, 'willRenew': true},
    {'productId': 'pro', 'expiresAt': 'invalid', 'willRenew': true},
    {'productId': 'pro', 'expiresAt': null, 'willRenew': 'true'},
  ]) {
    test('rejects malformed active fields: $fields', () {
      expect(
        () => GetV2SubscriptionMeResponseUnion.fromJson({
          'status': 'ACTIVE',
          ...fields,
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  }

  test(
    'sync POST preserves authentication and parses the shared response',
    () async {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.example.test',
          headers: {'Authorization': 'Bearer test-device-token'},
        ),
      );
      addTearDown(dio.close);
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            expect(options.method, 'POST');
            expect(options.path, '/v2/subscription/sync');
            expect(options.data, isNull);
            expect(options.queryParameters, isEmpty);
            expect(
              options.headers['Authorization'],
              'Bearer test-device-token',
            );
            handler.resolve(
              Response<Map<String, dynamic>>(
                requestOptions: options,
                statusCode: 200,
                data: {'status': 'INACTIVE'},
              ),
            );
          },
        ),
      );
      final response = await SubscriptionApiClient(dio)
          .postV2SubscriptionSync();
      expect(response.response.statusCode, 200);
      expect(
        response.data,
        isA<GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse>(),
      );
    },
  );
}
