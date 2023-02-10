import 'package:eqmonitor/flavors.dart';
import 'package:eqmonitor/main.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  F.appFlavor = Flavor.DEV;
  await commonMain();
}
