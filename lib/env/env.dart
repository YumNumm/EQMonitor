// ignore_for_file: avoid_classes_with_only_static_members

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  /// 電文履歴(telegram)取得用のアクセストークンとURL
  @EnviedField(varName: 'SUPABASE_S1_ANONKEY', obfuscate: true)
  static final supabaseS1AnonKey = _Env.supabaseS1AnonKey;
  @EnviedField(varName: 'SUPABASE_S1_URL', obfuscate: true)
  static final supabaseS1Url = _Env.supabaseS1Url;

  /// WebSocketに接続する用のSupabase CloudのアクセストークンとURL
  /// https://supabase.co/docs/api/authentication/
  @EnviedField(varName: 'SUPABASE_S2_ANONKEY', obfuscate: true)
  static final supabaseS2AnonKey = _Env.supabaseS2AnonKey;
  @EnviedField(varName: 'SUPABASE_S2_URL', obfuscate: true)
  static final supabaseS2Url = _Env.supabaseS2Url;

  /// DMDATA Parameter API Key
  @EnviedField(varName: 'DMDATA_KEY', obfuscate: true)
  static final dmdataKey = _Env.dmdataKey;
  @EnviedField(varName: 'DMDATA_ORIGIN', obfuscate: true)
  static final dmdataOrigin = _Env.dmdataOrigin;
  @EnviedField(varName: 'EQMONITOR_WEBSOCKET_URL', obfuscate: true)
  static final eqmonitorWebSocketUrl = _Env.eqmonitorWebSocketUrl;
}
