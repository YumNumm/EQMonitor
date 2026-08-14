/// 不変条件により非 null が保証される値を、理由付きで取り出す。
extension NullableValueRequirement<T extends Object> on T? {
  /// [because] には「なぜ非 null と言えるのか」を書く。
  ///
  /// 想定が破れた場合は理由付きの [StateError] となる。`!` の
  /// `Null check operator used on a null value` と違い、
  /// クラッシュログから前提条件を特定できる。
  ///
  /// `?.` によるnull 伝播・フロー解析・型の見直しで解決できる箇所では
  /// これを使わないこと。
  T orFailBecause(String because) {
    final value = this;
    if (value == null) {
      throw StateError('必ず非 null のはずの値が null でした: $because');
    }
    return value;
  }
}
