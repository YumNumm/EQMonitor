import 'package:eqmonitor/flavors.dart';
import 'package:eqmonitor/main.dart';

Future<void> main() async {
  F.appFlavor = Flavor.PROD;
  await commonMain();
}
