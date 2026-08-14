part of '../page/onboarding_page.dart';

class _NotificationSettingsStepPage extends HookConsumerWidget {
  const _NotificationSettingsStepPage({required this.navigation});

  final _OnboardingStepNavigation navigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMigrated =
        ref.watch(deviceMigratedFromLegacyProvider).value ?? false;
    if (isMigrated) {
      return _MigratedNotificationSettingsStepPage(navigation: navigation);
    }
    return _NewUserNotificationSettingsStepPage(navigation: navigation);
  }
}

class _MigratedNotificationSettingsStepPage extends HookConsumerWidget {
  const _MigratedNotificationSettingsStepPage({required this.navigation});

  final _OnboardingStepNavigation navigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;

    useEffect(() {
      navigation.register(
        _StepNavigationState(
          buttonLabel: '次へ',
          processingLabel: '処理しています...',
          isNextEnabled: true,
          isProcessing: false,
          onNext: navigation.nextPage,
        ),
      );
      return null;
    }, [navigation]);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: designSystem.spacing.xxxxl),
          Text('通知設定', style: designSystem.typography.displayMedium),
          SizedBox(height: designSystem.spacing.sm),
          Text(
            '前バージョンの通知設定を引き継ぎました',
            style: designSystem.typography.bodyLarge.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: designSystem.spacing.xl),
          Container(
            padding: EdgeInsets.all(designSystem.spacing.md),
            decoration: BoxDecoration(
              color: designSystem.colorTheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(designSystem.shape.card),
              border: Border.all(
                color: designSystem.colorTheme.status.success.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: designSystem.colorTheme.status.success,
                ),
                SizedBox(width: designSystem.spacing.sm),
                Expanded(
                  child: Text(
                    '通知の地域や震度の設定がそのまま引き継がれています。'
                    '設定はいつでも変更できます。',
                    style: designSystem.typography.bodySmall.copyWith(
                      color: designSystem.colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _NewUserNotificationSettingsStepPage extends HookConsumerWidget {
  const _NewUserNotificationSettingsStepPage({required this.navigation});

  final _OnboardingStepNavigation navigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final selectedPreset = useState<NotificationPreset?>(null);
    final hasSaveError = useState(false);
    final isProcessing = useState(false);

    Future<void> onNext() async {
      final preset = selectedPreset.value;
      if (preset == null) {
        return;
      }

      isProcessing.value = true;
      hasSaveError.value = false;
      try {
        await ref.read(notificationPresetApplierProvider).apply(preset);
        if (!context.mounted) {
          return;
        }

        if (preset == NotificationPreset.custom) {
          isProcessing.value = false;
          await Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (_) => const _OnboardingCustomSettingsWrapper(),
            ),
          );
          if (context.mounted) {
            await navigation.nextPage();
          }
        } else {
          isProcessing.value = false;
          await navigation.nextPage();
        }
      } on Exception catch (_) {
        if (context.mounted) {
          isProcessing.value = false;
          hasSaveError.value = true;
        }
      }
    }

    useEffect(() {
      navigation.register(
        _StepNavigationState(
          buttonLabel: '次へ',
          processingLabel: '通知設定を保存しています...',
          isNextEnabled: selectedPreset.value != null,
          isProcessing: isProcessing.value,
          onNext: onNext,
        ),
      );
      return null;
    }, [navigation, selectedPreset.value, isProcessing.value]);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: designSystem.spacing.xxxxl),
            Text('通知設定', style: designSystem.typography.displayMedium),
            SizedBox(height: designSystem.spacing.sm),
            Text(
              '細かい設定は後からでも変更できます',
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.colorTheme.outline,
              ),
            ),
            SizedBox(height: designSystem.spacing.xl),
            NotificationPresetSelector(
              selectedPreset: selectedPreset.value,
              onChanged: (preset) {
                selectedPreset.value = preset;
                hasSaveError.value = false;
              },
              style: NotificationPresetSelectorStyle.onboarding,
            ),
            if (hasSaveError.value) ...[
              SizedBox(height: designSystem.spacing.md),
              Text(
                '設定の保存に失敗しました。もう一度お試しください。',
                style: designSystem.typography.bodySmall.copyWith(
                  color: designSystem.colorTheme.error,
                ),
              ),
            ],
            SizedBox(height: designSystem.spacing.xl),
          ],
        ),
      ),
    );
  }
}

class _OnboardingCustomSettingsWrapper extends StatelessWidget {
  const _OnboardingCustomSettingsWrapper();

  @override
  Widget build(BuildContext context) {
    return const NotificationSettingsPage();
  }
}
