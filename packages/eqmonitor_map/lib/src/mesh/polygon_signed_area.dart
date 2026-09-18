import 'dart:typed_data';

/// Int32 ringの符号付き面積の符号を、64bit累積のoverflowなしで返す。
/// 各辺の積差はsigned 64bit内に収まるため、累積だけが範囲を外れる時点で
/// `BigInt`へ切り替える。
final class PolygonSignedArea {
  const new();

  int sign(Int32List ring) {
    var sum = 0;
    BigInt? exactSum;
    for (var index = 0; index < ring.length ~/ 2; index++) {
      final next = (index + 1) % (ring.length ~/ 2);
      final term =
          ring[index * 2] * ring[next * 2 + 1] -
          ring[next * 2] * ring[index * 2 + 1];
      final currentExact = exactSum;
      if (currentExact != null) {
        exactSum = currentExact + BigInt.from(term);
      } else if ((term > 0 && sum > _maxSigned64 - term) ||
          (term < 0 && sum < _minSigned64 - term)) {
        exactSum = BigInt.from(sum) + BigInt.from(term);
      } else {
        sum += term;
      }
    }
    return exactSum?.sign ?? sum.sign;
  }
}

const _minSigned64 = -0x8000000000000000;
const _maxSigned64 = 0x7FFFFFFFFFFFFFFF;
