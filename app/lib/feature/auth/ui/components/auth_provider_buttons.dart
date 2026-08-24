import 'package:material_ui/material_ui.dart';

class AuthProviderButtons extends StatelessWidget {
  const new({
    required this.googleEnabled,
    required this.appleEnabled,
    required this.passkeySignInEnabled,
    required this.passkeyRegistrationEnabled,
    required this.isAppleAndroid,
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onPasskeySignInPressed,
    required this.onPasskeyRegistrationPressed,
    super.key,
  });

  final bool googleEnabled;
  final bool appleEnabled;
  final bool passkeySignInEnabled;
  final bool passkeyRegistrationEnabled;
  final bool isAppleAndroid;
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final VoidCallback onPasskeySignInPressed;
  final VoidCallback onPasskeyRegistrationPressed;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Nativeサインイン', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: googleEnabled ? onGooglePressed : null,
            icon: const Icon(Icons.login),
            label: const Text('Googleでサインイン'),
          ),
          const SizedBox(height: 8),
          FilledButton.tonalIcon(
            onPressed: appleEnabled ? onApplePressed : null,
            icon: const Icon(Icons.apple),
            label: const Text('Appleでサインイン'),
          ),
          if (isAppleAndroid) ...[
            const SizedBox(height: 4),
            Text(
              'AndroidではAppleの認証画面をCustom Tabで開きます。',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: passkeySignInEnabled ? onPasskeySignInPressed : null,
            icon: const Icon(Icons.key),
            label: const Text('Passkeyでサインイン'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: passkeyRegistrationEnabled
                ? onPasskeyRegistrationPressed
                : null,
            icon: const Icon(Icons.add_moderator_outlined),
            label: const Text('Passkeyを登録'),
          ),
        ],
      ),
    ),
  );
}
