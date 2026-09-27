import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_server_repository.g.dart';

@Riverpod(keepAlive: true)
Future<SubscriptionServerRepository> subscriptionServerRepository(
  Ref ref,
) async => SubscriptionServerRepository(
  client: (await ref.watch(apiClientProvider.future)).subscription,
);

enum SubscriptionApiFailure {
  unavailable,
  authenticationRequired,
  pending,
  invalidResponse,
}

class const SubscriptionApiException({
  required final SubscriptionApiFailure reason,
}) implements Exception;

class const SubscriptionServerRepository({
  required final api.SubscriptionApiClient client,
}) {
  Future<Result<SubscriptionStatus, SubscriptionApiException>> fetch({
    bool synchronize = false,
  }) async {
    try {
      final response = synchronize
          ? await client.postV2SubscriptionSync()
          : await client.getV2SubscriptionMe();
      return Success(response.data.toSubscriptionStatus());
    } on DioException catch (error) {
      return Failure(
        SubscriptionApiException(
          reason: switch (error.response?.statusCode) {
            401 => SubscriptionApiFailure.authenticationRequired,
            409 => SubscriptionApiFailure.pending,
            _ => SubscriptionApiFailure.unavailable,
          },
        ),
      );
    } catch (_) {
      return const Failure(
        SubscriptionApiException(
          reason: SubscriptionApiFailure.invalidResponse,
        ),
      );
    }
  }
}

extension ServerSubscriptionStatus on api.GetV2SubscriptionMeResponseUnion {
  SubscriptionStatus toSubscriptionStatus() => switch (this) {
    api.GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse(
      :final productId,
      :final expiresAt,
      :final willRenew,
    ) =>
      expiresAt != null && !expiresAt.isAfter(clock.now())
          ? const SubscriptionStatus.inactive()
          : SubscriptionStatus.active(
              productId: productId,
              expiresAt: expiresAt,
              willRenew: willRenew,
            ),
    api.GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse() =>
      const SubscriptionStatus.inactive(),
  };
}

extension SubscriptionSyncResult
    on Result<SubscriptionStatus, SubscriptionApiException> {
  SubscriptionStatus toSyncedStatus({required SubscriptionStatus previous}) =>
      switch (this) {
        Success(value: SubscriptionStatusActive() && final status) => status,
        Success() => const SubscriptionStatus.inactive(
          syncPhase: SubscriptionSyncPhase.pending,
        ),
        Failure(
          exception: SubscriptionApiException(
            reason: SubscriptionApiFailure.authenticationRequired,
          ),
        ) =>
          const SubscriptionStatus.inactive(
            syncPhase: SubscriptionSyncPhase.authenticationRequired,
          ),
        Failure(
          exception: SubscriptionApiException(
            reason: SubscriptionApiFailure.pending,
          ),
        ) =>
          previous.copyWith(syncPhase: SubscriptionSyncPhase.pending),
        Failure() => previous.copyWith(syncPhase: SubscriptionSyncPhase.failed),
      };
}
