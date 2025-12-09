import 'dart:typed_data';

import 'package:dart_azarashi/src/model/exception.dart';

/// UBXプロトコルのメッセージをデコードし、NMEA形式($QZQSM)に変換する
///
/// UBXメッセージフォーマット:
/// - Preamble: 0xB5 0x62
/// - Message Class: 0x02 (RXM)
/// - Message ID: 0x13 (SFRBX)
/// - Payload Length: 0x2C 0x00 (44 bytes, Little Endian)
/// - GNSS ID: 0x05 (QZSS)
/// - Satellite ID: PRN - 182
/// - その他のヘッダーとデータ
///
/// 参考: https://prioris.jp/gnss/docs/processing/qzqsm/
class UbloxDecoder {
  /// Creates a new [UbloxDecoder].
  const UbloxDecoder();

  /// UBXプリアンブル（同期文字）
  static const ubxPreamble1 = 0xB5;
  static const ubxPreamble2 = 0x62;

  /// UBX-RXM-SFRBX メッセージ
  static const ubxMessageClassRxm = 0x02;
  static const ubxMessageIdSfrbx = 0x13;

  /// GNSS ID for QZSS
  static const gnssIdQzss = 0x05;

  /// PRNから衛星IDへの変換テーブル
  static const _satelliteIdMap = <int, String>{
    183: '55', // QZS01
    184: '56', // QZS02
    185: '57', // QZS04
    186: '58', // QZS1R
    189: '61', // QZS03
  };

  /// UBXメッセージから$QZQSMセンテンスを抽出する
  ///
  /// [message] UBXメッセージ全体（プリアンブルからチェックサムまで）
  ///
  /// QZSS災危通報メッセージの場合は$QZQSM形式のセンテンスを返す。
  /// それ以外の場合はnullを返す。
  ///
  /// Throws [QzssDcrDecoderException] if decoding fails.
  String? decode(Uint8List message) {
    // 最小メッセージ長チェック (ヘッダー6 + ペイロード44 + チェックサム2 = 52)
    if (message.length < 52) {
      return null;
    }

    // プリアンブルチェック
    if (message[0] != ubxPreamble1 || message[1] != ubxPreamble2) {
      return null;
    }

    // メッセージクラスとIDチェック (RXM-SFRBX)
    if (message[2] != ubxMessageClassRxm || message[3] != ubxMessageIdSfrbx) {
      return null;
    }

    // ペイロード長チェック (Little Endian)
    final payloadLength = message[4] | (message[5] << 8);
    if (payloadLength != 44) {
      return null;
    }

    // 総メッセージ長チェック
    final expectedLength = 6 + payloadLength + 2; // ヘッダー + ペイロード + チェックサム
    if (message.length < expectedLength) {
      return null;
    }

    // GNSS IDチェック (QZSS)
    if (message[6] != gnssIdQzss) {
      return null;
    }

    // チェックサム検証
    final checksumA = message[6 + payloadLength];
    final checksumB = message[6 + payloadLength + 1];
    final (calculatedA, calculatedB) = _calculateChecksum(
      message.sublist(2, 6 + payloadLength),
    );

    if (checksumA != calculatedA || checksumB != calculatedB) {
      throw QzssDcrDecoderException(
        'UBX Checksum Mismatch',
        sentence: message.toString(),
      );
    }

    // Satellite ID取得 (PRN = Satellite ID + 182)
    final prn = message[7] + 182;
    final satelliteId = _satelliteIdMap[prn];
    if (satelliteId == null) {
      // 未知の衛星IDの場合はスキップ
      return null;
    }

    // データ部分を取得 (9ワード × 4バイト = 36バイト)
    // ビッグエンディアンに変換
    final data = Uint8List(36);
    for (var i = 0; i < 9; i++) {
      final offset = 14 + i * 4;
      data[i * 4] = message[offset + 3];
      data[i * 4 + 1] = message[offset + 2];
      data[i * 4 + 2] = message[offset + 1];
      data[i * 4 + 3] = message[offset];
    }

    // メッセージタイプチェック (43=JMA-DC Report, 44=Other Organization)
    final messageType = data[1] >> 2;
    if (messageType != 43 && messageType != 44) {
      return null;
    }

    // 252ビット（31.5バイト）のデータを16進文字列に変換
    final hexData = StringBuffer();
    for (var i = 0; i < 31; i++) {
      hexData.write(data[i].toRadixString(16).padLeft(2, '0'));
    }
    // 最後のバイトの上位2ビットを追加
    hexData.write(((data[31] & 0xC0) >> 4).toRadixString(16));

    // $QZQSMセンテンスを生成
    final sentence = '\$QZQSM,$satelliteId,$hexData';

    // チェックサム計算
    var checksum = 0;
    for (var i = 1; i < sentence.length; i++) {
      checksum ^= sentence.codeUnitAt(i);
    }

    return '$sentence*${checksum.toRadixString(16).padLeft(2, '0')}';
  }

  /// UBXチェックサムを計算する
  ///
  /// [data] チェックサム対象データ（Message Class から Payload の最後まで）
  ///
  /// Returns (CK_A, CK_B)
  (int, int) _calculateChecksum(Uint8List data) {
    var ckA = 0;
    var ckB = 0;

    for (final byte in data) {
      ckA = (ckA + byte) & 0xFF;
      ckB = (ckB + ckA) & 0xFF;
    }

    return (ckA, ckB);
  }
}
