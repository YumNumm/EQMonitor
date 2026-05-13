import 'dart:math' as math;

/// 複素数を表すクラス
class Complex {
  const Complex(this.re, this.im);

  /// 実部
  final double re;

  /// 虚部
  final double im;

  /// 共役複素数
  Complex get conjugate => Complex(re, -im);

  /// 絶対値（振幅）
  double get abs => math.sqrt(re * re + im * im);

  /// 位相（ラジアン）
  double get phase => math.atan2(im, re);

  /// 絶対値の二乗
  double get absSq => re * re + im * im;

  Complex operator +(Complex other) => Complex(re + other.re, im + other.im);
  Complex operator -(Complex other) => Complex(re - other.re, im - other.im);

  /// 複素数または実数スカラーとの乗算
  Complex operator *(Object other) {
    if (other is Complex) {
      return Complex(re * other.re - im * other.im, re * other.im + im * other.re);
    } else if (other is num) {
      final s = other.toDouble();
      return Complex(re * s, im * s);
    }
    throw ArgumentError('Unsupported type: ${other.runtimeType}');
  }

  Complex operator /(double scalar) => Complex(re / scalar, im / scalar);

  @override
  String toString() => 'Complex($re, $im)';
}
