import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_crashlytics.g.dart';

@Riverpod(keepAlive: true)
FirebaseCrashlytics firebaseCrashlytics(Ref ref) =>
    FirebaseCrashlytics.instance;
