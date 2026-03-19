import 'package:better_auth_client/better_auth_client.dart';
import 'package:eqmonitor/core/auth/secure_storage_token_store.dart';
import 'package:eqmonitor/core/provider/secure_storage.dart';
import 'package:eqmonitor/core/util/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_client_provider.g.dart';

const _betterAuthBaseUrl = 'https://auth.eqmonitor.app/api/auth';

String get _authCallbackScheme => Env.flavor == Flavor.dev
    ? 'net.yumnumm.eqmonitor.dev'
    : 'net.yumnumm.eqmonitor';

@Riverpod(keepAlive: true)
BetterAuthClient authClient(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  final tokenStore = SecureStorageTokenStore(storage);
  return BetterAuthClient(
    baseUrl: _betterAuthBaseUrl,
    tokenStore: tokenStore,
    scheme: '$_authCallbackScheme://',
  );
}
