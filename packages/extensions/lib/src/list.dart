/// getOrNull
extension SafeListAccess<T> on List<T> {
  /// 指定したインデックスの要素を取得する
  /// インデックスが範囲外の場合はnullを返す
  T? getOrNull(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }
}

extension SafeMapAccess<K, V> on Map<K, V> {
  /// 指定したキーの要素を取得する
  /// キーが存在しない場合はnullを返す
  V? getOrNull(K key) {
    if (!containsKey(key)) {
      return null;
    }
    return this[key] as V;
  }
}

extension ListIndexWhereOrNull<T> on List<T> {
  /// 条件に合致する最初の要素のインデックスを取得する
  /// 条件に合致する要素が存在しない場合はnullを返す
  int? indexWhereOrNull(bool Function(T) test) {
    final index = indexWhere(test);
    if (index == -1) {
      return null;
    }
    return index;
  }
}
