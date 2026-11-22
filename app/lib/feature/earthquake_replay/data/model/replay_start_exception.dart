enum ReplayStartFailure(final String message) {
  outOfRange('強震モニタで再生できる期間（地震の発生からおよそ3時間）を過ぎています。'),
  liveEewActive('緊急地震速報の発表中は再生できません。'),
}

class const ReplayStartException(final ReplayStartFailure failure)
    implements Exception {
  @override
  String toString() => failure.message;
}
