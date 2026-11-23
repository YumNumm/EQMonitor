enum ReplayLibraryFailure(final String message) {
  invalidName('この名前は使えません。「/」や先頭の「.」を含まない名前を入力してください。'),
  invalidDirectory('このフォルダ名は使えません。「2026/11」のように「/」で区切って入力してください。'),
  nameConflict('同じ名前のファイルがすでにあります。別の名前を入力してください。'),
}

class const ReplayLibraryException(final ReplayLibraryFailure failure)
    implements Exception {
  @override
  String toString() => failure.message;
}
