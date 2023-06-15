/// getOrNull
extension SafeListAccess on List{
  /// 指定したインデックスの要素を取得する
  /// インデックスが範囲外の場合はnullを返す
  T? getOrNull<T>(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index] as T;
  }
}