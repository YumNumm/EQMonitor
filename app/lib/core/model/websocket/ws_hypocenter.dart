import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_hypocenter.freezed.dart';
part 'ws_hypocenter.g.dart';

@freezed
abstract class WsHypocenter with _$WsHypocenter {
  const factory WsHypocenter({
    required int regionCode,
    required String originTime,
    String? regionName,
    double? magnitude,
    double? depthKm,
  }) = _WsHypocenter;

  factory WsHypocenter.fromJson(Map<String, dynamic> json) =>
      _$WsHypocenterFromJson(json);
}
