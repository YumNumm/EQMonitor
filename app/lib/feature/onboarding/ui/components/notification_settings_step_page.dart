part of '../page/onboarding_page.dart';

class _NotificationSettingsStepPage extends HookConsumerWidget {
  const _NotificationSettingsStepPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scope = _OnboardingScope.of(context);
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final selectedPreset = useState<_NotificationPreset?>(null);
    final saveError = useState<String?>(null);
    final isProcessing = useState(false);

    Future<void> createCurrentLocationSlot() async {
      final notifier = ref.read(notificationSlotsProvider.notifier);
      await notifier.putCurrentLocation(
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.four,
        earthquakeEnabled: true,
        earthquakeMinIntensity: JmaIntensity.one,
      );
    }

    Future<void> saveRecommendedSettings() async {
      isProcessing.value = true;
      saveError.value = null;
      try {
        await createCurrentLocationSlot();
        if (context.mounted) {
          isProcessing.value = false;
          await scope.nextPage();
        }
      } on Exception catch (e) {
        if (context.mounted) {
          isProcessing.value = false;
          saveError.value = e.toString();
        }
      }
    }

    Future<void> onNext() async {
      switch (selectedPreset.value) {
        case .recommended:
          await saveRecommendedSettings();
        case .custom:
          isProcessing.value = true;
          saveError.value = null;
          try {
            await createCurrentLocationSlot();
          } on Exception catch (e) {
            if (context.mounted) {
              isProcessing.value = false;
              saveError.value = e.toString();
            }
            return;
          }
          if (!context.mounted) {
            return;
          }
          isProcessing.value = false;
          await Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (_) => const _OnboardingCustomSettingsWrapper(),
            ),
          );
          if (context.mounted) {
            await scope.nextPage();
          }
        case null:
          break;
      }
    }

    useEffect(() {
      scope.setStepNavigation(
        step: _OnboardingStep.notificationSettings,
        state: _StepNavigationState(
          buttonLabel: '次へ',
          isNextEnabled: selectedPreset.value != null,
          isProcessing: isProcessing.value,
          onNext: onNext,
        ),
      );
      return null;
    }, [scope, selectedPreset.value, isProcessing.value]);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: designSystem.spacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: designSystem.spacing.xxxxl),
            Text(
              '通知設定',
              style: designSystem.typography.displayMedium,
            ),
            SizedBox(height: designSystem.spacing.sm),
            Text(
              '細かい設定は後からでも変更できます',
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.textColor.tertiary,
              ),
            ),
            SizedBox(height: designSystem.spacing.xl),
            _PresetCard(
              title: '推奨設定',
              isSelected: selectedPreset.value == .recommended,
              onTap: () => selectedPreset.value = .recommended,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BulletItem(
                    text: '現在地の緊急地震速報(警報)',
                    designSystem: designSystem,
                  ),
                  _BulletItem(
                    text: '現在地で予想震度4以上の緊急地震速報(予報)',
                    designSystem: designSystem,
                  ),
                  _BulletItem(
                    text: '現在地で震度1以上の地震情報',
                    designSystem: designSystem,
                  ),
                ],
              ),
            ),
            SizedBox(height: designSystem.spacing.md),
            _PresetCard(
              title: 'カスタム',
              isSelected: selectedPreset.value == .custom,
              onTap: () => selectedPreset.value = .custom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BulletItem(
                    text: '通知する地域や震度を細かく設定できます',
                    designSystem: designSystem,
                  ),
                  _BulletItem(
                    text: 'Proではさらに通知音や割り込みレベルを設定できます',
                    designSystem: designSystem,
                  ),
                ],
              ),
            ),
            if (saveError.value != null) ...[
              SizedBox(height: designSystem.spacing.md),
              Text(
                '設定の保存に失敗しました。もう一度お試しください。',
                style: designSystem.typography.bodySmall.copyWith(
                  color: designSystem.palette.statusDanger,
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

class _PresetCard extends StatelessWidget {
  const _PresetCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.all(designSystem.spacing.md),
        decoration: BoxDecoration(
          color: designSystem.color.surfaceCard,
          borderRadius: BorderRadius.circular(designSystem.shape.card),
          border: Border.all(
            color: isSelected
                ? designSystem.palette.brandPrimary
                : designSystem.color.outlineSoft,
            width: isSelected ? 2 : 0,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected
                      ? designSystem.palette.brandPrimary
                      : designSystem.textColor.tertiary,
                  size: 20,
                ),
                SizedBox(width: designSystem.spacing.sm),
                Expanded(
                  child: Text(
                    title,
                    style: designSystem.typography.titleMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: designSystem.spacing.sm),
            Padding(
              padding: EdgeInsets.only(
                left: designSystem.spacing.lg + designSystem.spacing.xs,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({
    required this.text,
    required this.designSystem,
  });

  final String text;
  final DesignSystemThemeExtension designSystem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: designSystem.spacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '・',
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.textColor.secondary,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.textColor.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
