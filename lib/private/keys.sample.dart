import 'package:oauth1/oauth1.dart' as oauth1;

final clientCredentials = oauth1.ClientCredentials(
  '[Twitter API ]',
  '[Twitter API ]',
);

/// 電文履歴(telegram)取得用のアクセストークンとURL
///
const String supabaseS1AnonKey = '[Supabase Anon Key]';
const String supabaseS1Url = '[Supabase Url]';

/// WebSocketに接続する用のSupabase CloudのアクセストークンとURL
/// https://supabase.co/docs/api/authentication/
const String supabaseS2AnonKey = '[Supabase Anon Key]';
const String supabaseS2Url = '[Supabase Url]';

/// DMDATA Parameter API Key
const String dmdataKey = '[DMDATA Parameter API Key]';
