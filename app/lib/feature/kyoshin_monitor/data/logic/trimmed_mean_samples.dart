/// 直近 [capacity] 件を保持し、最小値と最大値を除いた平均を返すサンプル列。
///
/// 単一サンプルだと 1 回の通信ゆらぎが次の再同期まで残り続けてしまうため、
/// 外れ値を落としてから平均する。長周期地震動モニタの公式フロントエンドが
/// 往復時間とサーバ時刻のずれに対して行っているのと同じ処理。
class TrimmedMeanSamples {
  new({this.capacity = 5}) : assert(capacity > 0, 'capacity must be positive');

  final int capacity;
  final _samples = <Duration>[];

  /// 保持しているサンプル数
  int get length => _samples.length;

  bool get isEmpty => _samples.isEmpty;

  /// 保持しているサンプル(追加順)
  List<Duration> get samples => List.unmodifiable(_samples);

  void add(Duration value) {
    _samples.add(value);
    while (_samples.length > capacity) {
      _samples.removeAt(0);
    }
  }

  void clear() => _samples.clear();

  /// 3 件以上ある場合は最小・最大を除いた平均、それ未満は単純平均を返す。
  ///
  /// サンプルが無い場合は null。
  Duration? get value {
    if (_samples.isEmpty) {
      return null;
    }
    final sorted = [..._samples]..sort();
    final target = sorted.length >= 3
        ? sorted.sublist(1, sorted.length - 1)
        : sorted;
    final total = target.fold<int>(
      0,
      (sum, duration) => sum + duration.inMicroseconds,
    );
    return Duration(microseconds: total ~/ target.length);
  }
}
