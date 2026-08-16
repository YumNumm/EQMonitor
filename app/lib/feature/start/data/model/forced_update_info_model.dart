import 'package:eqmonitor/feature/start/data/model/required_version_model.dart';
import 'package:eqmonitor/feature/start/data/model/store_url_model.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forced_update_info_model.freezed.dart';

/// 強制アップデート判定に必要な情報のみを保持するドメインモデル。
@freezed
abstract class ForcedUpdateInfoModel with _$ForcedUpdateInfoModel {
  const factory ForcedUpdateInfoModel({
    required List<RequiredVersionModel> requiredVersions,
    required StoreUrlModel storeUrl,
  }) = _ForcedUpdateInfoModel;
}

extension StartResponseForcedUpdateExtension on api.StartResponse {
  ForcedUpdateInfoModel toForcedUpdateInfoModel() => ForcedUpdateInfoModel(
    requiredVersions: app.version.requiredVersions
        .map((e) => e.toRequiredVersionModel())
        .toList(),
    storeUrl: app.storeUrl.toStoreUrlModel(),
  );
}
