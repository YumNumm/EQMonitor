import 'package:freezed_annotation/freezed_annotation.dart';

part 'qzss_serial_port_state.freezed.dart';

/// QZSSシリアルポート接続の状態
@freezed
abstract class QzssSerialPortState with _$QzssSerialPortState {
  const factory QzssSerialPortState({
    required bool isConnected,
    required String? portName,
    required int baudRate,
    String? error,
  }) = _QzssSerialPortState;
}
