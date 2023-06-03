import 'package:freezed_annotation/freezed_annotation.dart';

part 'socket_status.freezed.dart';
part 'socket_status.g.dart';

@freezed
class SocketStatusModel with _$SocketStatusModel {
  const factory SocketStatusModel({
    @Default(false) bool connected,
  }) = _SocketStatusModel;

  factory SocketStatusModel.fromJson(Map<String, dynamic> json) =>
      _$SocketStatusModelFromJson(json);
}

enum SocketStatusType {
  disconnected,
  connecting,
  connected,
  error,
  reconnecting;
}
