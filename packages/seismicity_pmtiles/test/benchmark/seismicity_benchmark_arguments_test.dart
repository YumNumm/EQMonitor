import 'package:test/test.dart';

import '../../benchmark/seismicity_benchmark_arguments.dart';

void main() {
  const parser = SeismicityBenchmarkArgumentsParser();

  test('defaults to 2M features with no threshold', () {
    final args = parser.parse(arguments: const []);
    expect(args.featureCount, 2_000_000);
    expect(args.featuresPerTile, 1_000);
    expect(args.chunkCapacity, 65_536);
    expect(args.tileCount, 2_000);
    expect(args.informationalTimeThreshold, isNull);
  });

  test('parses all positive integer flags', () {
    final args = parser.parse(
      arguments: const [
        '--features',
        '10000',
        '--features-per-tile',
        '1000',
        '--chunk-capacity',
        '1024',
        '--informational-time-threshold-ms',
        '60000',
      ],
    );
    expect(args.featureCount, 10_000);
    expect(args.featuresPerTile, 1_000);
    expect(args.chunkCapacity, 1_024);
    expect(
      args.informationalTimeThreshold,
      const Duration(milliseconds: 60000),
    );
  });

  test('rejects missing unknown duplicate zero negative fraction overflow positional', () {
    expect(
      () => parser.parse(arguments: const ['--features']),
      throwsA(isA<SeismicityBenchmarkArgumentsException>()),
    );
    expect(
      () => parser.parse(arguments: const ['--unknown', '1']),
      throwsA(isA<SeismicityBenchmarkArgumentsException>()),
    );
    expect(
      () => parser.parse(
        arguments: const ['--features', '1', '--features', '2'],
      ),
      throwsA(isA<SeismicityBenchmarkArgumentsException>()),
    );
    expect(
      () => parser.parse(arguments: const ['--features', '0']),
      throwsA(isA<SeismicityBenchmarkArgumentsException>()),
    );
    expect(
      () => parser.parse(arguments: const ['--features', '-1']),
      throwsA(isA<SeismicityBenchmarkArgumentsException>()),
    );
    expect(
      () => parser.parse(arguments: const ['--features', '1.5']),
      throwsA(isA<SeismicityBenchmarkArgumentsException>()),
    );
    expect(
      () => parser.parse(
        arguments: const ['--features', '9223372036854775808'],
      ),
      throwsA(isA<SeismicityBenchmarkArgumentsException>()),
    );
    expect(
      () => parser.parse(arguments: const ['positional']),
      throwsA(isA<SeismicityBenchmarkArgumentsException>()),
    );
  });
}
