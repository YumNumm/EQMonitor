/// Immutable parsed CLI arguments for the seismicity decode benchmark harness.
final class SeismicityBenchmarkArguments {
  const SeismicityBenchmarkArguments({
    required this.featureCount,
    required this.featuresPerTile,
    required this.chunkCapacity,
    required this.informationalTimeThreshold,
  });

  static const defaultFeatureCount = 2_000_000;
  static const defaultFeaturesPerTile = 1_000;
  static const defaultChunkCapacity = 65_536;

  final int featureCount;
  final int featuresPerTile;
  final int chunkCapacity;
  final Duration? informationalTimeThreshold;

  int get tileCount => featureCount ~/ featuresPerTile;
}

/// Strict typed parser for benchmark CLI flags. Parsing only — no benchmark run.
final class SeismicityBenchmarkArgumentsParser {
  const SeismicityBenchmarkArgumentsParser();

  static const usage =
      'Usage: seismicity_pmtiles_decode_benchmark.dart '
      '[--features <positive-int>] '
      '[--features-per-tile <positive-int>] '
      '[--chunk-capacity <positive-int>] '
      '[--informational-time-threshold-ms <positive-int>]';

  SeismicityBenchmarkArguments parse({required List<String> arguments}) {
    var featureCount = SeismicityBenchmarkArguments.defaultFeatureCount;
    var featuresPerTile = SeismicityBenchmarkArguments.defaultFeaturesPerTile;
    var chunkCapacity = SeismicityBenchmarkArguments.defaultChunkCapacity;
    Duration? informationalTimeThreshold;
    final seen = <String>{};
    const ints = SeismicityBenchmarkPositiveIntParser();

    for (var index = 0; index < arguments.length; index++) {
      final flag = arguments[index];
      if (!flag.startsWith('--')) {
        throw SeismicityBenchmarkArgumentsException(
          message: 'Positional arguments are not allowed: $flag\n$usage',
        );
      }
      if (!seen.add(flag)) {
        throw SeismicityBenchmarkArgumentsException(
          message: 'Duplicate flag: $flag\n$usage',
        );
      }
      if (index + 1 >= arguments.length) {
        throw SeismicityBenchmarkArgumentsException(
          message: 'Missing value for $flag\n$usage',
        );
      }
      final raw = arguments[++index];
      final value = ints.parse(flag: flag, raw: raw, usage: usage);
      switch (flag) {
        case '--features':
          featureCount = value;
        case '--features-per-tile':
          featuresPerTile = value;
        case '--chunk-capacity':
          chunkCapacity = value;
        case '--informational-time-threshold-ms':
          informationalTimeThreshold = Duration(milliseconds: value);
        default:
          throw SeismicityBenchmarkArgumentsException(
            message: 'Unknown flag: $flag\n$usage',
          );
      }
    }
    return SeismicityBenchmarkArguments(
      featureCount: featureCount,
      featuresPerTile: featuresPerTile,
      chunkCapacity: chunkCapacity,
      informationalTimeThreshold: informationalTimeThreshold,
    );
  }
}

final class SeismicityBenchmarkPositiveIntParser {
  const SeismicityBenchmarkPositiveIntParser();

  static final _pattern = RegExp(r'^[1-9][0-9]*$');
  static const _maxInt64 = 9223372036854775807;

  int parse({
    required String flag,
    required String raw,
    required String usage,
  }) {
    if (!_pattern.hasMatch(raw)) {
      throw SeismicityBenchmarkArgumentsException(
        message: 'Invalid integer for $flag: $raw\n$usage',
      );
    }
    final value = int.tryParse(raw);
    if (value == null || value <= 0 || value > _maxInt64) {
      throw SeismicityBenchmarkArgumentsException(
        message: '$flag overflows or is non-positive: $raw\n$usage',
      );
    }
    return value;
  }
}

final class SeismicityBenchmarkArgumentsException implements Exception {
  const SeismicityBenchmarkArgumentsException({required this.message});

  final String message;

  @override
  String toString() => message;
}
