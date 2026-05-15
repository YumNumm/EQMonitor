import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ads_server_flag_provider.g.dart';

/// Start API実装前のスタブ。サーバから取得した ads_enabled フラグに置き換える。
@Riverpod(keepAlive: true)
bool adsServerFlag(Ref ref) => true;
