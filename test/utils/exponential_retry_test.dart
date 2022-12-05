import 'package:flutter_test/flutter_test.dart';

void main() {
  test('overflow', () async {});
}

class _SampleExceptional {
  _SampleExceptional(this.exceptionCount);
  final int exceptionCount;
  int _count = 0;

  Future<int> run() async {
    if (_count < exceptionCount) {
      _count++;
      throw Exception('Exception');
    }
    return _count;
  }
}
