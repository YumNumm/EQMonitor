import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'initial_route.g.dart';

/// アプリ起動時の初期ルートを保持するProvider
/// main.dartでオーバーライドされる
@Riverpod(keepAlive: true)
String initialRoute(Ref ref) => '/';
