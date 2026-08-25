import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/model/debug_auth_state.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/notifier/debug_auth_notifier.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:eqmonitor/feature/auth/data/provider/native_auth_availability_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/native_social_auth_repository.dart';
import 'package:eqmonitor/feature/auth/ui/components/auth_provider_buttons.dart';
import 'package:eqmonitor/feature/auth/ui/components/auth_session_summary.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class DebugAuthPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildConfig = ref.watch(buildConfigProvider);
    final selectedApi = ref.watch(telegramUrlProvider);
    final environment = ref.watch(authEnvironmentProvider);
    final availability = ref.watch(nativeAuthAvailabilityProvider);
    final session = ref.watch(authSessionProvider);
    final authState = ref.watch(debugAuthProvider);
    final debugAuthReadiness = switch (authState) {
      AsyncData() => DebugAuthNotifierReadiness.ready,
      AsyncLoading() => DebugAuthNotifierReadiness.loading,
      AsyncError() => DebugAuthNotifierReadiness.failed,
    };
    final displayedState = switch (authState) {
      AsyncData(:final value) => value,
      AsyncLoading() => const DebugAuthState.restoring(),
      AsyncError() => const DebugAuthState.idle().withFailure(
        kind: AuthFailureKind.unknown,
      ),
    };
    final resolvedAvailability = switch (availability) {
      AsyncData(:final value) => value,
      _ => const NativeAuthAvailability(
        environmentCompatible: false,
        googleAvailable: false,
        appleAvailable: false,
        passkeyAvailable: false,
      ),
    };
    final selectedApiLabel = switch (selectedApi) {
      AsyncData(:final value) => value.restApiUrl,
      AsyncLoading() => '読み込み中',
      AsyncError() => '取得失敗',
    };
    final environmentStatus = switch (environment) {
      AsyncData(:final value) when value is Success => '一致',
      AsyncData() => '不一致',
      AsyncLoading() => '確認中',
      AsyncError() => '確認失敗',
    };
    final expectedEnvironment = AuthEnvironment.forFlavor(
      buildConfig.flavor,
    );
    final platform = NativeAuthConfiguration.currentPlatform();
    final sessionStatus = switch (session) {
      AsyncData(:final value) => value.status,
      _ => null,
    };
    final isAuthenticated = sessionStatus == AuthSessionStatus.authenticated;
    final actions = resolvedAvailability.actions(
      isSessionReady: sessionStatus != null,
      isAuthenticated: isAuthenticated,
      isBusy: displayedState.isBusy,
      debugAuthReadiness: debugAuthReadiness,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Native認証デバッグ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AuthEnvironmentSummary(
            flavor: buildConfig.flavor.name,
            selectedApi: selectedApiLabel,
            expectedApi: expectedEnvironment.baseUrl,
            expectedPasskeyRpId: expectedEnvironment.passkeyRpId,
            environmentStatus: environmentStatus,
            socialFeatureEnabled: buildConfig.isNativeSocialAuthEnabled,
            googleAvailable: resolvedAvailability.googleAvailable,
            appleAvailable: resolvedAvailability.appleAvailable,
            passkeyAvailable: resolvedAvailability.passkeyAvailable,
          ),
          const SizedBox(height: 12),
          AuthSessionSummary(
            state: displayedState,
            sessionStatus: sessionStatus,
            sessionFailed: session is AsyncError,
            debugAuthReadiness: debugAuthReadiness,
          ),
          const SizedBox(height: 12),
          AuthProviderButtons(
            googleEnabled: actions.googleSignIn,
            appleEnabled: actions.appleSignIn,
            passkeySignInEnabled: actions.passkeySignIn,
            passkeyRegistrationEnabled: actions.passkeyRegistration,
            isAppleAndroid: platform == NativeAuthPlatform.android,
            onGooglePressed: () async =>
                ref.read(debugAuthProvider.notifier).signInWithGoogle(),
            onApplePressed: () async =>
                ref.read(debugAuthProvider.notifier).signInWithApple(),
            onPasskeySignInPressed: () async =>
                ref.read(debugAuthProvider.notifier).signInWithPasskey(),
            onPasskeyRegistrationPressed: () async =>
                ref.read(debugAuthProvider.notifier).registerPasskey(),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: actions.jwtRefresh
                        ? () async =>
                              ref.read(debugAuthProvider.notifier).refreshJwt()
                        : null,
                    icon: const Icon(Icons.refresh),
                    label: const Text('JWTを更新'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: actions.userMeVerification
                        ? () async => ref
                              .read(debugAuthProvider.notifier)
                              .verifyUserMe()
                        : null,
                    icon: const Icon(Icons.http),
                    label: const Text('GET /v2/user/me'),
                  ),
                  TextButton.icon(
                    onPressed: actions.signOut
                        ? () async =>
                              ref.read(debugAuthProvider.notifier).signOut()
                        : null,
                    icon: const Icon(Icons.logout),
                    label: const Text('ログアウト'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'token、Cookie、認可code、Passkey payload、メール全文は表示・記録しません。',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _AuthEnvironmentSummary extends StatelessWidget {
  const new({
    required this.flavor,
    required this.selectedApi,
    required this.expectedApi,
    required this.expectedPasskeyRpId,
    required this.environmentStatus,
    required this.socialFeatureEnabled,
    required this.googleAvailable,
    required this.appleAvailable,
    required this.passkeyAvailable,
  });

  final String flavor;
  final String selectedApi;
  final String expectedApi;
  final String expectedPasskeyRpId;
  final String environmentStatus;
  final bool socialFeatureEnabled;
  final bool googleAvailable;
  final bool appleAvailable;
  final bool passkeyAvailable;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: [
        ListTile(title: const Text('Build flavor'), subtitle: Text(flavor)),
        ListTile(
          title: const Text('選択中API'),
          subtitle: Text(selectedApi),
        ),
        ListTile(
          title: const Text('期待API'),
          subtitle: Text(expectedApi),
        ),
        ListTile(
          title: const Text('期待Passkey RP ID'),
          subtitle: Text(expectedPasskeyRpId),
        ),
        ListTile(
          title: const Text('環境整合性'),
          subtitle: Text(environmentStatus),
        ),
        ListTile(
          title: const Text('Native Social Auth feature gate'),
          subtitle: Text(socialFeatureEnabled ? '有効' : '無効'),
        ),
        ListTile(
          title: const Text('利用可能方式'),
          subtitle: Text(
            'Google: ${googleAvailable ? '可' : '不可'} / '
            'Apple: ${appleAvailable ? '可' : '不可'} / '
            'Passkey: ${passkeyAvailable ? '可' : '不可'}',
          ),
        ),
      ],
    ),
  );
}
