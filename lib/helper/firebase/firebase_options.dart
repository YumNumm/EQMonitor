import 'package:eqmonitor/flavors.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options_dev.dart';
import 'firebase_options_prod.dart';

// ignore: avoid_classes_with_only_static_members
class FirebaseOptionsWrapper {
  static FirebaseOptions get currentPlatform {
    switch (F.appFlavor) {
      case Flavor.DEV:
        return FirebaseOptionsDev.currentPlatform;
      case Flavor.PROD:
        return FirebaseOptionsProd.currentPlatform;
      case null:
        throw StateError('F.appFlavor is null');
    }
  }
}
