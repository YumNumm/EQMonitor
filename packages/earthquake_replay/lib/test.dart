import 'dart:io';

import 'package:earthquake_replay/src/parser/replay_data_parser.dart';

Future<void> main() async {
  final parser = ReplayDataParser();
  final data = parser.parse(File('test/20240101-能登7.eprp').readAsBytesSync());
  print(data);
}
