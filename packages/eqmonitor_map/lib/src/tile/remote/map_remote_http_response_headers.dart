import 'package:flutter/foundation.dart';

/// remote tile 取得の validator が参照する、HTTP レスポンスヘッダの最小
/// 抽象。dio / http どちらの client でもここへ正規化して渡すことで、validator
/// を特定の HTTP client 実装から切り離す(Global Constraints「地図側へ同等
/// 契約を移植または共有最小型のみ」)。
///
/// HTTP ヘッダ名は case-insensitive([RFC 9110])なので、lookup は小文字化して
/// 突き合わせる。`ETag` と `etag` のように **同名ヘッダが異なる casing で
/// 複数回渡された場合は値を結合** する(後勝ちで上書きしない)。上書きすると
/// 「単一の strong validator が来た」と誤認し、validator の「欠損・複数は
/// fail closed」契約を迂回してしまうため。
@immutable
final class MapRemoteHttpResponseHeaders {
  new(Map<String, List<String>> raw)
    : _byLowerName = {
        for (final lowerName in {
          for (final key in raw.keys) key.toLowerCase(),
        })
          lowerName: List.unmodifiable([
            for (final entry in raw.entries)
              if (entry.key.toLowerCase() == lowerName) ...entry.value,
          ]),
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
