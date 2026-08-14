import 'package:flutter/foundation.dart';

/// remote tile 取得の validator が参照する、HTTP レスポンスヘッダの最小
/// 抽象。dio / http どちらの client でもここへ正規化して渡すことで、validator
/// を特定の HTTP client 実装から切り離す(Global Constraints「地図側へ同等
/// 契約を移植または共有最小型のみ」)。
///
/// HTTP ヘッダ名は case-insensitive([RFC 9110])なので、lookup は小文字化して
/// 突き合わせる。
@immutable
final class MapRemoteHttpResponseHeaders {
  MapRemoteHttpResponseHeaders(Map<String, List<String>> raw)
    : _byLowerName = {
        for (final entry in raw.entries)
          entry.key.toLowerCase(): List.unmodifiable(entry.value),
      };

  final Map<String, List<String>> _byLowerName;

  /// [name](case-insensitive)に対応する全ての値。無ければ`null`。
  List<String>? valuesOf(String name) => _byLowerName[name.toLowerCase()];

  /// [name]がちょうど1つの値を持つときその値、それ以外(欠損・複数)は`null`。
  String? singleValueOf(String name) {
    final values = valuesOf(name);
    return values != null && values.length == 1 ? values.single : null;
  }
}
