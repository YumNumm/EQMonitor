import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';

final class DebugAuthFailurePresentation {
  const new();

  static String code(AuthFailureKind kind) => 'AuthFailureKind.${kind.name}';

  static String message(AuthFailureKind kind) => switch (kind) {
    AuthFailureKind.cancelled => '認証操作をキャンセルしました。',
    AuthFailureKind.busy => '別の認証処理が進行中です。',
    AuthFailureKind.configuration => 'Native認証の設定が完了していません。',
    AuthFailureKind.environmentMismatch => 'ビルドと接続先APIの環境が一致しません。',
    AuthFailureKind.sessionRequired => '先にサインインしてください。',
    AuthFailureKind.passkeyUnsupported => 'この端末ではPasskeyを利用できません。',
    AuthFailureKind.passkeyDomainAssociation => 'Passkeyのドメイン関連付けを確認してください。',
    AuthFailureKind.passkeyCredentialUnavailable => '利用できるPasskeyがありません。',
    AuthFailureKind.unauthorized => 'セッションが無効です。再度サインインしてください。',
    AuthFailureKind.rateLimited => 'しばらく待ってから再試行してください。',
    AuthFailureKind.server => '認証サーバーでエラーが発生しました。',
    AuthFailureKind.timeout => '認証処理がタイムアウトしました。',
    AuthFailureKind.network => 'ネットワーク接続を確認してください。',
    AuthFailureKind.invalidResponse => '認証サーバーの応答を確認できませんでした。',
    AuthFailureKind.storage => '端末内のセッション保存に失敗しました。',
    AuthFailureKind.unknown => '認証処理に失敗しました。',
  };
}

final class DebugAuthPresentation {
  const new();

  static String sessionStatusLabel({
    required DebugAuthState state,
    required AuthSessionStatus? sessionStatus,
    required bool sessionFailed,
    required DebugAuthNotifierReadiness debugAuthReadiness,
  }) => switch ((
    debugAuthReadiness,
    state.operation,
    state.failureKind,
    sessionStatus,
  )) {
    (DebugAuthNotifierReadiness.loading, _, _, _) => '認証デバッグを初期化中',
    (DebugAuthNotifierReadiness.failed, _, _, _) => '失敗: 認証デバッグを初期化できませんでした。',
    (_, final DebugAuthOperation operation, _, _) =>
      '更新中: ${operationLabel(operation)}',
    (_, _, final failure?, _) =>
      '失敗: ${DebugAuthFailurePresentation.message(failure)}',
    (_, _, _, _) when sessionFailed => '失敗: セッション状態を確認できませんでした。',
    (_, _, _, null) => 'セッション確認中',
    (_, _, _, AuthSessionStatus.authenticated) => '認証済み',
    _ => '未認証',
  };

  static String providerLabel(DebugAuthProviderKind? provider) =>
      switch (provider) {
        DebugAuthProviderKind.google => 'Google',
        DebugAuthProviderKind.apple => 'Apple',
        DebugAuthProviderKind.passkey => 'Passkey',
        null => '不明（復元セッション）',
      };

  static String operationLabel(DebugAuthOperation operation) =>
      switch (operation) {
        DebugAuthOperation.restoring => 'セッション復元中',
        DebugAuthOperation.googleSignIn => 'Googleサインイン中',
        DebugAuthOperation.appleSignIn => 'Appleサインイン中',
        DebugAuthOperation.passkeySignIn => 'Passkeyサインイン中',
        DebugAuthOperation.passkeyRegistration => 'Passkey登録中',
        DebugAuthOperation.jwtRefresh => 'JWT更新中',
        DebugAuthOperation.userMeVerification => '/v2/user/me 確認中',
        DebugAuthOperation.signOut => 'ログアウト中',
      };

  static String successLabel(DebugAuthSuccessKind success) => switch (success) {
    DebugAuthSuccessKind.restored => 'セッションを復元しました。',
    DebugAuthSuccessKind.signedIn => 'サインインしました。',
    DebugAuthSuccessKind.passkeyRegistered => 'Passkeyを登録しました。',
    DebugAuthSuccessKind.jwtRefreshed => 'JWTを更新しました。',
    DebugAuthSuccessKind.userMeVerified => '/v2/user/me への疎通に成功しました。',
    DebugAuthSuccessKind.signedOut => 'ログアウトしました。',
  };
}
