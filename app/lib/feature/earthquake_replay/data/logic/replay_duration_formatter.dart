class const ReplayDurationFormatter() {
  String format(Duration duration) {
    final totalSeconds = duration.isNegative ? 0 : duration.inSeconds;
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
