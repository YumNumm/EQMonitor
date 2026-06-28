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

    Future<void> saveRecommendedSettings() async {
      isProcessing.value = true;
      saveError.value = null;
      try {
        await ref.read(eewSettingsProvider.future);
        await ref.read(eewSettingsProvider.notifier).addCurrentLocationRegion();

        await ref.read(earthquakeNotificationSettingsProvider.future);
        await ref
            .read(earthquakeNotificationSettingsProvider.notifier)
            .addCurrentLocationRegion(minIntensity: JmaIntensity.one);

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
        case .advanced:
          await saveRecommendedSettings();
        case .custom:
          if (!context.mounted) {
            return;
          }
          await Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (_) => const OnboardingCustomSettingsPage(),
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
          crossAxisAlignment: .stretch,
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
                    text: '現在地で震度1以上を観測',
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
                    text: '緊急地震速報と地震情報について、追加で1地域まで指定',
                    designSystem: designSystem,
                  ),
                  _BulletItem(
                    text: '現在地の緊急地震速報(警報)有無',
                    designSystem: designSystem,
                  ),
                ],
              ),
            ),
            SizedBox(height: designSystem.spacing.md),
            _PresetCard(
              title: '高度な設定',
              badge: 'PRO',
              isSelected: selectedPreset.value == _NotificationPreset.advanced,
              onTap: () => selectedPreset.value = _NotificationPreset.advanced,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BulletItem(
                    text: '緊急地震速報と地震情報について、追加で最大5地域まで指定',
                    designSystem: designSystem,
                  ),
                  _BulletItem(
                    text: '予想震度や観測震度に合わせた通知音・通知割り込みレベルのカスタマイズ',
                    designSystem: designSystem,
                  ),
                  SizedBox(height: designSystem.spacing.sm),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('課金について見る'),
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

class _PresetCard extends StatelessWidget {
  const _PresetCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.child,
    this.badge,
  });

  final String title;
  final String? badge;
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
                if (badge != null) ...[
                  SizedBox(width: designSystem.spacing.xs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: designSystem.spacing.xs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: designSystem.palette.brandPrimary.withValues(
                        alpha: 0.15,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      badge!,
                      style: designSystem.typography.labelSmall.copyWith(
                        color: designSystem.palette.brandPrimary,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ],
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
