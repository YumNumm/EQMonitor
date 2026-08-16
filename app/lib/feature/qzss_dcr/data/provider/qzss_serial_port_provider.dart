import 'dart:async';

import 'package:dart_azarashi/dart_azarashi.dart';
import 'package:eqmonitor/feature/qzss_dcr/data/model/qzss_serial_port_state.dart';
import 'package:eqmonitor/feature/qzss_dcr/data/service/qzss_serial_port_service.dart';
import 'package:libserialport_plus/libserialport_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qzss_serial_port_provider.g.dart';

/// 利用可能なシリアルポートのリストを取得
@riverpod
List<String> availableSerialPorts(Ref ref) => SerialPort.getAvailablePorts();

/// QZSSシリアルポート接続管理プロバイダー
@riverpod
class QzssSerialPortConnection extends _$QzssSerialPortConnection {
  QzssSerialPortService? _service;

  @override
  QzssSerialPortState build() {
    ref.onDispose(() {
      unawaited(_service?.dispose());
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
      final service = QzssSerialPortService(
        portName: portName,
        baudRate: baudRate,
      );
      _service = service;

      await service.connect();

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

    state = state.copyWith(isConnected: false, error: null);
  }

  // ignore: avoid_public_notifier_properties
  /// 災危通報ストリーム
  Stream<QzssDcReport>? get reportStream => _service?.reportStream;
}

/// 最新の災危通報レポート
@riverpod
class LatestQzssDcReport extends _$LatestQzssDcReport {
  @override
  QzssDcReport? build() {
    final connection = ref.watch(qzssSerialPortConnectionProvider);
    final connectionNotifier = ref.watch(
      qzssSerialPortConnectionProvider.notifier,
    );

    if (connection.isConnected) {
      final stream = connectionNotifier.reportStream;
      if (stream != null) {
        final subscription = stream.listen((report) {
          state = report;
        });
        ref.onDispose(subscription.cancel);
      }
    }

    return null;
  }

  /// レポートをクリア
  void clear() {
    state = null;
  }
}
