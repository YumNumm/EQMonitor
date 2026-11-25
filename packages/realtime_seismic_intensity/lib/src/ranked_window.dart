import 'dart:typed_data';

// 全サンプルを値の順に並べた順位を Fenwick 木で数え、窓の中で k 番目に小さい値を O(log n) で引く。
final class RankedWindow({required final Float64List values}) {
  this {
    _sorted = _sort();
  }

  late final Int32List _rankOf = Int32List(values.length);
  late final Float64List _sorted;
  late final Int32List _tree = Int32List(values.length + 1);
  late final int _highestBit = _highestPowerOfTwo(values.length);

  void add(int index) => _update(_rankOf[index] + 1, 1);

  void remove(int index) => _update(_rankOf[index] + 1, -1);

  double smallest(int k) {
    var position = 0;
    var remaining = k;
    for (var step = _highestBit; step > 0; step >>= 1) {
      final next = position + step;
      if (next < _tree.length && _tree[next] < remaining) {
        position = next;
        remaining -= _tree[next];
      }
    }
    return _sorted[position];
  }

  void _update(int position, int delta) {
    for (var i = position; i < _tree.length; i += i & -i) {
      _tree[i] += delta;
    }
  }

  static const _radixBits = 11;
  static const _radixMask = (1 << _radixBits) - 1;

  // 0 以上の倍精度浮動小数点数はビット列を整数とみなしても大小が保たれるため、比較を使わない
  // 安定な基数ソートで並べる。Int64List.sort は 30,000 サンプルで約 20 倍遅かった。
  Float64List _sort() {
    final length = values.length;
    var keys = Float64List.fromList(values).buffer.asInt64List();
    var order = Int32List(length);
    for (var i = 0; i < length; i++) {
      if (values[i] < 0 || values[i].isNaN) {
        throw ArgumentError.value(values[i], 'values', 'must be >= 0');
      }
      order[i] = i;
    }
    var nextKeys = Int64List(length);
    var nextOrder = Int32List(length);
    final counts = Int32List(_radixMask + 2);
    for (var shift = 0; shift < 64; shift += _radixBits) {
      counts.fillRange(0, counts.length, 0);
      for (var i = 0; i < length; i++) {
        counts[((keys[i] >> shift) & _radixMask) + 1]++;
      }
      for (var digit = 0; digit <= _radixMask; digit++) {
        counts[digit + 1] += counts[digit];
      }
      for (var i = 0; i < length; i++) {
        final position = counts[(keys[i] >> shift) & _radixMask]++;
        nextKeys[position] = keys[i];
        nextOrder[position] = order[i];
      }
      (keys, nextKeys) = (nextKeys, keys);
      (order, nextOrder) = (nextOrder, order);
    }
    final sorted = Float64List(length);
    for (var rank = 0; rank < length; rank++) {
      _rankOf[order[rank]] = rank;
      sorted[rank] = values[order[rank]];
    }
    return sorted;
  }

  int _highestPowerOfTwo(int n) {
    var bit = 1;
    while (bit * 2 <= n) {
      bit *= 2;
    }
    return bit;
  }
}
