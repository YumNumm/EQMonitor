import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const AuthProviderButtons({
  required final bool googleEnabled,
  required final bool appleEnabled,
  required final bool passkeySignInEnabled,
  required final bool passkeyRegistrationEnabled,
  required final bool isAppleAndroid,
  required final VoidCallback onGooglePressed,
  required final VoidCallback onApplePressed,
  required final VoidCallback onPasskeySignInPressed,
  required final VoidCallback onPasskeyRegistrationPressed,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Text('Nativeサインイン', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          M3EFilledButton.icon(
            onPressed: googleEnabled ? onGooglePressed : null,
            icon: const Icon(Icons.login),
            label: const Text('Googleでサインイン'),
          ),
          const SizedBox(height: 8),
          M3EFilledButton.tonalIcon(
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
          M3EOutlinedButton.icon(
            onPressed: passkeySignInEnabled ? onPasskeySignInPressed : null,
            icon: const Icon(Icons.key),
            label: const Text('Passkeyでサインイン'),
          ),
          const SizedBox(height: 8),
          M3EOutlinedButton.icon(
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
