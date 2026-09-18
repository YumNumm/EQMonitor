import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';
import 'package:eqmonitor/feature/auth/ui/model/debug_auth_presentation.dart';
import 'package:material_ui/material_ui.dart';

class AuthSessionSummary extends StatelessWidget {
  const new({
    required this.state,
    required this.sessionStatus,
    required this.sessionFailed,
    required this.debugAuthReadiness,
    super.key,
  });

  final DebugAuthState state;
  final AuthSessionStatus? sessionStatus;
  final bool sessionFailed;
  final DebugAuthNotifierReadiness debugAuthReadiness;

  @override
  Widget build(BuildContext context) {
    final statusLabel = DebugAuthPresentation.sessionStatusLabel(
      state: state,
      sessionStatus: sessionStatus,
      sessionFailed: sessionFailed,
      debugAuthReadiness: debugAuthReadiness,
    );
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
          if (sessionStatus == AuthSessionStatus.authenticated)
            ListTile(
              title: const Text('認証方式'),
              subtitle: Text(
                DebugAuthPresentation.providerLabel(state.provider),
              ),
            ),
          if (sessionStatus == AuthSessionStatus.authenticated)
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
          if (state.failureKind case final failure?)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(DebugAuthFailurePresentation.code(failure)),
            ),
        ],
      ),
    );
  }
}
