import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jma_map_isolate_message.freezed.dart';

@freezed
abstract class JmaMapCalculateMessage with _$JmaMapCalculateMessage {
  const factory({
    required int id,
    required JmaMapType type,
    required double lat,
    required double lng,
  }) = _JmaMapCalculateMessage;
}

@freezed
abstract class JmaMapShutdownMessage with _$JmaMapShutdownMessage {
  const factory() = _JmaMapShutdownMessage;
}

@freezed
abstract class JmaMapResponseMessage with _$JmaMapResponseMessage {
  const factory({
    required int id,
    MapDataItem? result,
    String? errorMessage,
    String? errorStack,
  }) = _JmaMapResponseMessage;
}
