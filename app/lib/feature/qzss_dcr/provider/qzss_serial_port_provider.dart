import 'package:dart_azarashi/dart_azarashi.dart';
import 'package:libserialport_plus/libserialport_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../service/qzss_serial_port_service.dart';

part 'qzss_serial_port_provider.g.dart';

/// 利用可能なシリアルポートのリストを取得
@riverpod
List<String> availableSerialPorts(AvailableSerialPortsRef ref) {
  return SerialPort.getAvailablePorts();
}

/// QZSSシリアルポート接続の状態
class QzssSerialPortState {
  const QzssSerialPortState({
    required this.isConnected,
    required this.portName,
    required this.baudRate,
    this.error,
  });

  final bool isConnected;
  final String? portName;
  final int baudRate;
  final String? error;

  QzssSerialPortState copyWith({
    bool? isConnected,
    String? portName,
    int? baudRate,
    String? error,
  }) {
    return QzssSerialPortState(
      isConnected: isConnected ?? this.isConnected,
      portName: portName ?? this.portName,
      baudRate: baudRate ?? this.baudRate,
      error: error ?? this.error,
    );
  }
}

/// QZSSシリアルポート接続管理プロバイダー
@riverpod
class QzssSerialPortConnection extends _$QzssSerialPortConnection {
  QzssSerialPortService? _service;

  @override
  QzssSerialPortState build() {
    ref.onDispose(() {
      _service?.dispose();
    });

    return const QzssSerialPortState(
      isConnected: false,
      portName: null,
      baudRate: 115200,
    );
  }

  /// シリアルポートに接続
  Future<void> connect(String portName, int baudRate) async {
    try {
      // 既存の接続を切断
      await disconnect();

      // 新しいサービスを作成
      _service = QzssSerialPortService(
        portName: portName,
        baudRate: baudRate,
      );

      await _service!.connect();

      state = QzssSerialPortState(
        isConnected: true,
        portName: portName,
        baudRate: baudRate,
      );
    } catch (e) {
      state = QzssSerialPortState(
        isConnected: false,
        portName: portName,
        baudRate: baudRate,
        error: e.toString(),
      );
      rethrow;
    }
  }

  /// 接続を切断
  Future<void> disconnect() async {
    await _service?.disconnect();
    _service = null;

    state = state.copyWith(
      isConnected: false,
      error: null,
    );
  }

  /// 災危通報ストリーム
  Stream<QzssDcReport>? get reportStream => _service?.reportStream;
}

/// 最新の災危通報レポート
@riverpod
class LatestQzssDcReport extends _$LatestQzssDcReport {
  @override
  QzssDcReport? build() {
    final connection = ref.watch(qzssSerialPortConnectionProvider);
    final connectionNotifier =
        ref.watch(qzssSerialPortConnectionProvider.notifier);

    if (connection.isConnected) {
      final stream = connectionNotifier.reportStream;
      if (stream != null) {
        stream.listen((report) {
          state = report;
        });
      }
    }

    return null;
  }

  /// レポートをクリア
  void clear() {
    state = null;
  }
}
