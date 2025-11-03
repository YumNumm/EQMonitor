import 'package:nied_api_client/src/hinet/aqua/model/aqua_event_type.dart';
import 'package:timezone/timezone.dart';

/// 発震機構解画像のURL生成ユーティリティ
class FocalMechanismUrlGenerator {
  /// ベースURL
  static const _baseUrl = 'https://www.hinet.bosai.go.jp/hypo/AQUA';

  /// 通常画像URL
  ///
  /// 発震機構解のビーチボール図のURLを生成します
  ///
  /// [id] イベントID（yyyyMMddHHmmss形式の文字列）
  /// [type] 解析タイプ（AQUA-CMTまたはAQUA-MT）
  ///
  /// Returns: 画像のURL
  ///
  /// Example:
  /// ```dart
  /// final url = FocalMechanismUrlGenerator().normal(
  ///   id: '20251103000018',
  ///   type: AquaEventType.cmt,
  /// );
  /// // https://www.hinet.bosai.go.jp/hypo/AQUA/AQUA-CMT/2025/11/20251103000018.png
  /// ```
  String normal({
    required String id,
    required AquaEventType type,
  }) {
    // IDからyyyy/MMを抽出
    final year = id.substring(0, 4);
    final month = id.substring(4, 6);

    return '$_baseUrl/${type.fullName}/$year/$month/$id.png';
  }

  /// 詳細画像URL
  ///
  /// 発震機構解の詳細情報を含む画像のURLを生成します
  ///
  /// [id] イベントID（yyyyMMddHHmmss形式の文字列）
  /// [type] 解析タイプ（AQUA-CMTまたはAQUA-MT）
  ///
  /// Returns: 詳細画像のURL
  ///
  /// Example:
  /// ```dart
  /// final url = FocalMechanismUrlGenerator().detail(
  ///   id: '20251103000018',
  ///   type: AquaEventType.cmt,
  /// );
  /// // https://www.hinet.bosai.go.jp/hypo/AQUA/AQUA-CMT/2025/11/20251103000018.d.png
  /// ```
  String detail({
    required String id,
    required AquaEventType type,
  }) {
    // IDからyyyy/MMを抽出
    final year = id.substring(0, 4);
    final month = id.substring(4, 6);

    return '$_baseUrl/${type.fullName}/$year/$month/$id.d.png';
  }
}
