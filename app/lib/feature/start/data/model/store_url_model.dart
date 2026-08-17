import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_url_model.freezed.dart';

@freezed
abstract class StoreUrlModel with _$StoreUrlModel {
  const factory({required String ios, required String android}) =
      _StoreUrlModel;
}

extension StoreUrlApiExtension on api.StoreUrl {
  StoreUrlModel toStoreUrlModel() => StoreUrlModel(ios: ios, android: android);
}
