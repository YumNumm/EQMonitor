import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'information_repository.g.dart';

@Riverpod(keepAlive: true)
InformationRepository informationRepository(InformationRepositoryRef ref) =>
    InformationRepository(ref.watch(eqApiProvider));

class InformationRepository {
  InformationRepository(this._api);

  final EqApi _api;

  Future<Result<InformationV3Result, Exception>> fetchInformation({
    required int limit,
    required int offset,
  }) async =>
      Result.capture(
        () => _api.v3.getInformation(
          limit: limit,
          offset: offset,
        ),
      );
}
