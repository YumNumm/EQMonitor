import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:flutter/material.dart';

class OnboardingCustomSettingsPage extends StatelessWidget {
  const OnboardingCustomSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ds = Theme.of(context).designSystemThemeExtension;

    return Scaffold(
      backgroundColor: ds.color.backgroundDefault,
      appBar: AppBar(
        title: const Text('カスタム設定'),
        backgroundColor: ds.color.backgroundDefault,
      ),
      body: const Center(
        child: Placeholder(
          fallbackHeight: 500,
          child: Center(
            child: Text('カスタム設定（後日実装）'),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            ds.spacing.lg,
            ds.spacing.md,
            ds.spacing.lg,
            ds.spacing.xxl,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: ds.palette.brandPrimary,
                foregroundColor: ds.textColor.inverse,
                shape: RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(ds.shape.button),
                ),
              ),
              child: Text(
                '次へ',
                style: ds.typography.labelLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
