/// AQUA カタログAPIの言語設定
enum Language {
  /// 日本語
  japanese('ja'),

  /// 英語
  english('en')
  ;

  const Language(this.code);

  /// 言語コード
  final String code;
}
