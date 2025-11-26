import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_azarashi/dart_azarashi.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption(
      'type',
      abbr: 't',
      help: 'Message type',
      allowed: ['hex', 'nmea', 'ublox'],
      mandatory: true,
    )
    ..addOption(
      'input',
      abbr: 'f',
      help: 'Input file (default: stdin)',
      defaultsTo: 'stdin',
    )
    ..addFlag(
      'source',
      abbr: 's',
      help: 'Output the source messages',
      defaultsTo: false,
    )
    ..addFlag('verbose', abbr: 'v', help: 'Verbose mode', defaultsTo: false)
    ..addFlag('help', abbr: 'h', help: 'Show help', negatable: false);

  late final ArgResults results;
  try {
    results = parser.parse(arguments);
  } on FormatException catch (e) {
    stderr.writeln('Error: ${e.message}');
    stderr.writeln();
    _printUsage(parser);
    exit(1);
  }

  if (results.flag('help')) {
    _printUsage(parser);
    exit(0);
  }

  final type = results.option('type');
  final inputPath = results.option('input') ?? 'stdin';
  final showSource = results.flag('source');
  final verbose = results.flag('verbose');

  final azarashi = DartAzarashi();
  final Stream<String> inputStream;

  if (inputPath == 'stdin') {
    inputStream = stdin.transform(const SystemEncoding().decoder);
  } else {
    final file = File(inputPath);
    if (!file.existsSync()) {
      stderr.writeln('Error: File not found: $inputPath');
      exit(1);
    }
    inputStream = file.openRead().transform(const SystemEncoding().decoder);
  }

  inputStream
      .transform(const LineSplitter())
      .listen(
        (line) {
          if (line.trim().isEmpty) return;

          final now = DateTime.now().toIso8601String();

          try {
            final QzssDcReport report;

            switch (type) {
              case 'hex':
                report = azarashi.hexDecoder.decode(line);
              case 'nmea':
                report = azarashi.nmeaDecoder.decode(line);
              case 'ublox':
                // u-blox binary requires special handling
                stderr.writeln('Error: ublox type requires binary input');
                return;
              default:
                stderr.writeln('Error: Unknown type: $type');
                return;
            }

            stdout.writeln('$now --------------------------------');
            if (verbose) {
              _printVerbose(report);
            } else {
              stdout.writeln(report);
            }
            stdout.writeln();

            if (showSource) {
              stdout.writeln('# src: $line');
              final rawBytes = switch (report) {
                QzssDcReportEarthquakeEarlyWarning(:final raw) => raw,
                QzssDcReportHypocenter(:final raw) => raw,
                QzssDcReportSeismicIntensity(:final raw) => raw,
                QzssDcReportTsunami(:final raw) => raw,
                QzssDcReportNankaiTroughEarthquake(:final raw) => raw,
                QzssDcReportNorthwestPacificTsunami(:final raw) => raw,
                QzssDcReportFlood(:final raw) => raw,
                QzssDcReportMarine(:final raw) => raw,
                QzssDcReportWeather(:final raw) => raw,
                QzssDcReportVolcano(:final raw) => raw,
                QzssDcReportAshFall(:final raw) => raw,
                QzssDcReportTyphoon(:final raw) => raw,
                QzssDcReportDcxNull(:final raw) => raw,
                QzssDcReportDcxOutsideJapan(:final raw) => raw,
                QzssDcReportDcxLAlert(:final raw) => raw,
                QzssDcReportDcxJAlert(:final raw) => raw,
                QzssDcReportDcxMTInfo(:final raw) => raw,
                QzssDcReportDcxUnknown(:final raw) => raw,
              };
              final hex = rawBytes
                  .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
                  .join();
              stdout.writeln('# hex: $hex');
              stdout.writeln();
            }
          } on QzssDcrDecoderException catch (e) {
            stderr.writeln('$now --------------------------------');
            stderr.writeln('# [QzssDcrDecoderException] $e');
            stderr.writeln();
          } on QzssDcrDecoderNotImplementedError catch (e) {
            stderr.writeln('$now --------------------------------');
            stderr.writeln('# [QzssDcrDecoderNotImplementedError] $e');
            stderr.writeln();
          } catch (e) {
            stderr.writeln('$now --------------------------------');
            stderr.writeln('# [${e.runtimeType}] $e');
            stderr.writeln();
          }
        },
        onDone: () {
          exit(0);
        },
        onError: (Object e) {
          stderr.writeln('Error: $e');
          exit(1);
        },
      );
}

void _printUsage(ArgParser parser) {
  stdout.writeln('dart_azarashi - QZQSM DCR Decoder CLI');
  stdout.writeln();
  stdout.writeln('Usage: dart_azarashi -t <type> [options]');
  stdout.writeln();
  stdout.writeln('Options:');
  stdout.writeln(parser.usage);
  stdout.writeln();
  stdout.writeln('Examples:');
  stdout.writeln('  echo "\$QZQSM,58,..." | dart_azarashi -t nmea');
  stdout.writeln('  dart_azarashi -t hex -f input.txt');
}

void _printVerbose(QzssDcReport report) {
  stdout.writeln('Type: ${report.runtimeType}');
  stdout.writeln('Sentence: ${report.sentence}');
  print(JsonEncoder.withIndent('  ').convert(report.toJson()));

}
