import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_crashlytics.g.dart';

@Riverpod(keepAlive: true)
FirebaseCrashlytics firebaseCrashlytics(FirebaseCrashlyticsRef ref) =>
    FirebaseCrashlytics.instance;
