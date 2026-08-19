/// AQUA カタログAPIの言語設定
enum Language {
  /// 日本語
  japanese('ja'),

  /// 英語
  english('en');

  new(this.code);

  /// 言語コード
  final String code;
}
