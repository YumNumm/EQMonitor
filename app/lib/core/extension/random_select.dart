import 'dart:math';

extension RandomSelect<T> on List<T> {
  T get randomSelect => this[Random().nextInt(length)];
}
