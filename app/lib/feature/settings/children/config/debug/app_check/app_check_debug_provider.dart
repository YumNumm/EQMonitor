import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_check_debug_provider.g.dart';

@riverpod
Stream<String?> appCheckToken(Ref ref) async* {
  final initialToken = await FirebaseAppCheck.instance.getToken();
  yield initialToken;
  yield* FirebaseAppCheck.instance.onTokenChange;
}
