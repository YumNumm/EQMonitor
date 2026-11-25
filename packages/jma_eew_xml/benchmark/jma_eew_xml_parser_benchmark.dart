import 'dart:convert';
import 'dart:io';

import 'package:jma_eew_xml/jma_eew_xml.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tree.dart';
import 'package:xml/xml.dart';

Future<void> main(List<String> arguments) async {
  final directory = arguments.isEmpty ? 'test/fixtures' : arguments.first;
  const fixtures = [
    '77_01_01_240613_VXSE45.xml',
    '77_01_05_240613_VXSE45.xml',
    '77_01_17_240613_VXSE45.xml',
  ];
  const parser = JmaEewXmlParser();
  const treeBuilder = JmaXmlTreeBuilder();
  const runner = JmaEewXmlBenchmarkRunner(
    minimumDuration: Duration(seconds: 2),
  );
  stdout.writeln('| 電文 | サイズ | 処理 | 1 回あたり | 処理量 |');
  stdout.writeln('| --- | ---: | --- | ---: | ---: |');
  for (final name in fixtures) {
    final xml = File('$directory/$name').readAsStringSync();
    final bytes = utf8.encode(xml).length;
    final cases = <String, void Function()>{
      'JmaEewXmlParser.parse': () => parser.parse(xml),
      'JmaXmlTreeBuilder.build': () => treeBuilder.build(xml),
      'XmlDocument.parse (package:xml)': () => XmlDocument.parse(xml),
    };
    for (final MapEntry(key: label, value: body) in cases.entries) {
      final micros = runner.measure(body);
      final megabytesPerSecond = bytes / micros;
      stdout.writeln(
        '| $name | ${(bytes / 1024).toStringAsFixed(1)} KiB | $label | '
        '${micros.toStringAsFixed(2)} µs | '
        '${megabytesPerSecond.toStringAsFixed(1)} MB/s |',
      );
    }
  }
}

final class const JmaEewXmlBenchmarkRunner({
  required final Duration minimumDuration,
}) {
  static const _warmupIterations = 2000;

  double measure(void Function() body) {
    for (var i = 0; i < _warmupIterations; i++) {
      body();
    }
    var iterations = 0;
    final stopwatch = Stopwatch()..start();
    while (stopwatch.elapsed < minimumDuration) {
      for (var i = 0; i < 100; i++) {
        body();
      }
      iterations += 100;
    }
    stopwatch.stop();
    return stopwatch.elapsedMicroseconds / iterations;
  }
}
