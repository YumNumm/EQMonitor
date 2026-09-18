import 'package:firebase_app_check/firebase_app_check.dart';

/// AppCheck トークン取得失敗を DioException に乗せるシグナル。
/// AppCheckInterceptor が `DioException.error` にセットし、
/// Dio マッパーが `e.error is AppCheckRejection` で検出する。
final class const AppCheckRejection(final FirebaseException cause);
