/// ExponentialRetryのテスト
import 'package:eqmonitor/utils/exponential_retry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('overflow', () async {
    try{

    final sample = _SampleExceptional(5);
     await ExponentialBackoff().retry<int>(sample.run , onError: (exception, stackTrace, retryCount) {
      print('retryCount: $retryCount');
     },);
    } catch (e) {
      print(e);
    }
  });
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
