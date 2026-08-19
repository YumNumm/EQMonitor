import 'dart:async';
import 'dart:typed_data';

import 'package:dart_azarashi/dart_azarashi.dart';
import 'package:libserialport_plus/libserialport_plus.dart';

/// QZSSシリアルポート接続サービス
///
/// UBX-RXM-SFRBXメッセージを有効化するコマンド
final _valSetRamUbxRxmSfrbxUart1On = Uint8List.fromList([
  0xB5,
  0x62,
  0x06,
  0x8A,
  0x09,
  0x00,
  0x01,
  0x01,
  0x00,
  0x00,
  0x32,
  0x02,
  0x91,
  0x20,
  0x01,
  0x81,
  0x30,
]);

class QzssSerialPortService {
  new({required this.portName, required this.baudRate});

  final String portName;
  final int baudRate;

  SerialPort? _port;
  SerialPortReader? _reader;
  StreamSubscription<Uint8List>? _subscription;

  final _controller = StreamController<QzssDcReport>.broadcast();
  final _nmeaDecoder = const NmeaDecoder();
  final _ubloxDecoder = const UbloxDecoder();

  /// 災危通報のストリーム
  Stream<QzssDcReport> get reportStream => _controller.stream;

  /// 接続状態
  bool get isConnected => _port?.isOpen() ?? false;

  /// シリアルポートに接続
  Future<void> connect() async {
    if (isConnected) {
      throw StateError('Already connected');
    }

    // ポートを開く
    final port = SerialPort(portName);
    _port = port;

    // ポートを開く
    port.open();

    // ボーレートを設定
    port.setConfig(SerialPortConfig(baudRate: baudRate));

    // UBX-RXM-SFRBXを有効化
    port.write(_valSetRamUbxRxmSfrbxUart1On);

    // リーダーを作成してデータを読み取る
    final reader = SerialPortReader(port);
    _reader = reader;
    _subscription = reader.stream.listen(_onData);
  }

  /// 切断
  Future<void> disconnect() async {
    await _subscription?.cancel();
    _subscription = null;

    await _reader?.close();
    _reader = null;

    _port?.close();
    _port?.dispose();
    _port = null;
  }

  final _buffer = <int>[];
  var _readingNmea = false;
  var _readingUbx = false;
  var _ubxPayloadLength = 0;

  void _onData(Uint8List data) {
    for (final byte in data) {
      _buffer.add(byte);

      // UBXメッセージの検出
      if (_buffer.length >= 2 &&
          _buffer[_buffer.length - 2] == 0xB5 &&
          byte == 0x62) {
        _readingUbx = true;
        _readingNmea = false;
        _buffer.clear();
        _buffer.addAll([0xB5, 0x62]);
        continue;
      }

      // NMEAセンテンスの検出
      if (byte == 0x24 && !_readingUbx) {
        // '$'
        _readingNmea = true;
        _buffer.clear();
        _buffer.add(byte);
        continue;
      }

      if (_readingUbx) {
        // ペイロード長を取得
        if (_buffer.length == 6) {
          _ubxPayloadLength = _buffer[4] | (_buffer[5] << 8);
        }

        // UBXメッセージ完了判定
        if (_ubxPayloadLength > 0 &&
            _buffer.length == 6 + _ubxPayloadLength + 2) {
          _processUbxMessage(Uint8List.fromList(_buffer));
          _buffer.clear();
          _readingUbx = false;
          _ubxPayloadLength = 0;
        }
      } else if (_readingNmea) {
        // NMEAセンテンス完了判定 (\r\n)
        if (_buffer.length >= 2 &&
            _buffer[_buffer.length - 2] == 0x0D &&
            byte == 0x0A) {
          _processNmeaSentence(
            String.fromCharCodes(_buffer.sublist(0, _buffer.length - 2)),
          );
          _buffer.clear();
          _readingNmea = false;
        }
      }
    }
  }

  void _processUbxMessage(Uint8List message) {
    final sentence = _ubloxDecoder.decode(message);
    if (sentence != null) {
      final report = _nmeaDecoder.decode(sentence);
      _controller.add(report);
    }
  }

  void _processNmeaSentence(String sentence) {
    if (sentence.startsWith(r'$QZQSM')) {
      final report = _nmeaDecoder.decode(sentence);
      _controller.add(report);
    }
  }

  /// リソースを解放
  Future<void> dispose() async {
    await disconnect();
    await _controller.close();
  }
}
