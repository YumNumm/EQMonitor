/// AI チャットで利用するプロバイダー。
enum AiProvider {
  anthropic('Anthropic', 'claude-sonnet-4-5'),
  gemini('Google Gemini', 'gemini-2.5-pro'),
  openai('OpenAI', 'gpt-4o')
  ;

  const AiProvider(this.displayName, this.defaultModel);

  final String displayName;
  final String defaultModel;

  /// 各プロバイダーで選択可能な代表的なモデル。
  /// 一般的に利用される代表的な高品質モデルに絞っている。
  List<String> get availableModels => switch (this) {
    AiProvider.anthropic => const [
      'claude-sonnet-4-5',
      'claude-opus-4-5',
      'claude-haiku-4-5',
    ],
    AiProvider.gemini => const [
      'gemini-2.5-pro',
      'gemini-2.5-flash',
    ],
    AiProvider.openai => const [
      'gpt-4o',
      'gpt-4o-mini',
      'gpt-4.1',
    ],
  };
}
