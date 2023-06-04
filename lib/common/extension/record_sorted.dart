extension NumberRecordSorted on (num, num) {
  /// 小さい方を$1、大きい方を$2として返す
  (num, num) sorted() {
    return this.$1 < this.$2 ? (this.$1, this.$2) : (this.$2, this.$1);
  }
}
