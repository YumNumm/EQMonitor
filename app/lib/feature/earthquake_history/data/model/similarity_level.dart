enum SimilarityLevel {
  a(maxScore: 100),
  b(maxScore: 200),
  c(maxScore: 300),
  d(maxScore: 400),
  e(maxScore: 500);

  const SimilarityLevel({required this.maxScore});
  final double maxScore;

  int get filledCount => 5 - index;

  static SimilarityLevel fromScore(double score) {
    for (final level in values) {
      if (score <= level.maxScore) {
        return level;
      }
    }
    return SimilarityLevel.e;
  }
}
