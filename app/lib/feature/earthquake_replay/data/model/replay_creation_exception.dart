enum ReplayCreationFailure(final String message) {
  outOfRange('指定した期間の強震モニタ画像は取得できません。期間を選び直してください。'),
  noImageKind('含める強震モニタ画像を1つ以上選択してください。'),
  noFrames('指定した期間の強震モニタ画像を取得できませんでした。'),
  imageFetchFailed('強震モニタ画像の取得に失敗しました。通信環境を確認して、もう一度お試しください。'),
  eewFetchFailed('緊急地震速報の取得に失敗しました。通信環境を確認して、もう一度お試しください。'),
  cancelled('リプレイファイルの作成を中止しました。'),
}

class const ReplayCreationException(final ReplayCreationFailure failure)
    implements Exception {
  @override
  String toString() => failure.message;
}
