/// Int32座標の3点が作る外積の符号を正確に返す。
final class PolygonOrientation {
  const new();

  int sign({
    required int ax,
    required int ay,
    required int bx,
    required int by,
    required int cx,
    required int cy,
  }) {
    final abx = bx - ax;
    final aby = by - ay;
    final acx = cx - ax;
    final acy = cy - ay;
    if (_productFitsSigned64(abx, acy) && _productFitsSigned64(aby, acx)) {
      final left = abx * acy;
      final right = aby * acx;
      if (left != 0 && right != 0 && left.isNegative != right.isNegative) {
        return left.sign;
      }
      return (left - right).sign;
    }
    return (BigInt.from(abx) * BigInt.from(acy) -
            BigInt.from(aby) * BigInt.from(acx))
        .sign;
  }
}

const _maxSigned64 = 0x7FFFFFFFFFFFFFFF;

bool _productFitsSigned64(int left, int right) {
  final leftMagnitude = left.abs();
  final rightMagnitude = right.abs();
  return leftMagnitude == 0 || rightMagnitude <= _maxSigned64 ~/ leftMagnitude;
}
