import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';
import 'package:eqmonitor/feature/auth/ui/model/debug_auth_presentation.dart';
import 'package:material_ui/material_ui.dart';

class AuthSessionSummary extends StatelessWidget {
  const new({required this.state, super.key});

  final DebugAuthState state;

  @override
  Widget build(BuildContext context) {
    final statusLabel = switch ((
      state.operation,
      state.failureKind,
      state.sessionStatus,
    )) {
      (final DebugAuthOperation operation, _, _) =>
        '更新中: ${DebugAuthPresentation.operationLabel(operation)}',
      (_, final failure?, _) =>
        '失敗: ${DebugAuthFailurePresentation.message(failure)}',
      (_, _, AuthSessionStatus.authenticated) => '認証済み',
      _ => '未認証',
    };
    final expiryLabel =
        state.jwtExpiresAt?.toLocal().toIso8601String() ?? '未取得';
    final success = state.successKind;
    final summary = state.userSummary;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: const Icon(Icons.verified_user_outlined),
            title: const Text('認証状態'),
            subtitle: Text(statusLabel),
          ),
          if (state.isAuthenticated)
            ListTile(
              title: const Text('認証方式'),
              subtitle: Text(
                DebugAuthPresentation.providerLabel(state.provider),
              ),
            ),
          if (state.isAuthenticated)
            ListTile(
              title: const Text('JWT有効期限'),
              subtitle: Text(expiryLabel),
            ),
          if (summary != null)
            ListTile(
              title: const Text('/v2/user/me'),
              subtitle: Text(
                '成功 / ID: ${summary.abbreviatedUserId} / '
                'Email: ${summary.maskedEmail}',
              ),
            ),
          if (success != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(DebugAuthPresentation.successLabel(success)),
            ),
        ],
      ),
    );
  }
}
