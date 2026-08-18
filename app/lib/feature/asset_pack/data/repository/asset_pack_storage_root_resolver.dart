import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_storage_root_resolver.g.dart';

typedef ResolveAssetPackStorageRoot = Future<Directory> Function();

@Riverpod(keepAlive: true)
AssetPackStorageRootResolver assetPackStorageRootResolver(Ref ref) =>
    const AssetPackStorageRootResolver();

/// Asset Pack 関連のファイルをすべて収める、アプリ専用ディレクトリの解決。
///
/// 直下に同梱 Pack の展開先 `bundled/`、ダウンロード済み Pack の `packs/`、
/// 展開途中の `staging/` を置く。ユーザーには見えず、バックアップ対象にも
/// ならない `applicationSupport` 配下を使う。
class AssetPackStorageRootResolver {
  const new();

  Future<Directory> resolve() async {
    final supportDirectory = await getApplicationSupportDirectory();
    return Directory(p.join(supportDirectory.path, 'eqmonitor_asset_packs'));
  }
}
