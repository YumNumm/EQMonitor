/// getOrNull
extension SafeListAccess on List {
  /// 指定したインデックスの要素を取得する
  /// インデックスが範囲外の場合はnullを返す
  T? getOrNull<T>(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index] as T;
  }
}


extension SafeMapAccess on Map{
  /// 指定したキーの要素を取得する
  /// キーが存在しない場合はnullを返す
  T? getOrNull<T>(dynamic key) {
    if (!containsKey(key)) {
      return null;
    }
    return this[key] as T;
  }
}