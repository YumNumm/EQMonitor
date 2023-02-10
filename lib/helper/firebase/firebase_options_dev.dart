// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class FirebaseOptionsDev {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-Ptf9r3w1CLxSKP498gP_clal4DuTYrc',
    appId: '1:885756014256:android:0ae360be54126805011575',
    messagingSenderId: '885756014256',
    projectId: 'eqmonitor-dev',
    storageBucket: 'eqmonitor-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD92CPyPbgXHUtfwMbg2d8ea5jUsoeNLBI',
    appId: '1:885756014256:ios:a9172af56dfd3eb5011575',
    messagingSenderId: '885756014256',
    projectId: 'eqmonitor-dev',
    storageBucket: 'eqmonitor-dev.appspot.com',
    iosClientId: '885756014256-v8keka86cudkttofm2esmbvbrre8bf47.apps.googleusercontent.com',
    iosBundleId: 'net.yumnumm.eqmonitor',
  );
}
