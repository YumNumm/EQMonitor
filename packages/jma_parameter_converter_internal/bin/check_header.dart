import 'dart:io';

import 'package:jma_parameter_types/earthquake_param.pb.dart';
import 'package:jma_parameter_types/tsunami_param.pb.dart';

void main() {
  final eqBuffer = File('earthquake_parameter.buffer').readAsBytesSync();
  final eq = EarthquakeParameter.fromBuffer(eqBuffer);
  print('=== Earthquake Parameter Header ===');
  print('Version: ${eq.header.version}');
  print('ChangeTime: ${eq.header.changeTime}');
  print('Regions count: ${eq.regions.length}');

  final tsunamiBuffer = File('tsunami_parameter.buffer').readAsBytesSync();
  final tsunami = TsunamiParameter.fromBuffer(tsunamiBuffer);
  print('');
  print('=== Tsunami Parameter Header ===');
  print('Version: ${tsunami.header.version}');
  print('ChangeTime: ${tsunami.header.changeTime}');
  print('Items count: ${tsunami.items.length}');
}
