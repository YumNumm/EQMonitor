part of '../page/onboarding_page.dart';

class _PermissionsStepPage extends HookConsumerWidget {
  const _PermissionsStepPage({required this.navigation});

  static const _temporaryQaUrl = 'https://example.com';

  final _OnboardingStepNavigation navigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final permissionFlow = ref.watch(onboardingPermissionFlowProvider);
    final permissionState = ref.watch(permissionProvider);
    final isProcessing = _isPermissionRequestProcessing(ref);

    void openWebView({required String title}) {
      OnboardingWebViewRoute(
        title: title,
        url: _PermissionsStepPage._temporaryQaUrl,
      ).push<void>(context);
    }

    useEffect(() {
      if (!navigation.isActive) {
        return null;
      }
      final state = permissionState.value;
      navigation.register(
        _StepNavigationState(
          buttonLabel: '次へ',
          isNextEnabled: state?.canContinue ?? false,
          isProcessing: isProcessing || permissionState.isLoading,
          onNext: navigation.nextPage,
        ),
      );
      return null;
    }, [navigation, navigation.isActive, permissionState, isProcessing]);

    return permissionState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('権限の確認に失敗しました: $error'),
      ),
      data: (state) => Padding(
        padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
        child: ListView(
          children: [
            SizedBox(height: designSystem.spacing.xxxxl),
            Text('通知と位置情報', style: designSystem.typography.displayMedium),
            SizedBox(height: designSystem.spacing.xl),
            _PermissionSection(
              title: '1. 通知権限',
              children: [
                _PermissionActionCard(
                  title: '通知を許可',
                  description:
                      '地震情報や緊急地震速報を通知でお知らせします。通知を送る条件や地域はこの後設定できます',
                  decision: state.notification,
                  isEnabled: !isProcessing,
                  onSkip: () => permissionFlow.skipNotification(ref),
                  onAllow: () =>
                      permissionFlow.requestNotification(ref, context),
                ),
                if (state.isCriticalAlertVisible) ...[
                  SizedBox(height: designSystem.spacing.md),
                  _PermissionActionCard(
                    title: '重大な通知を許可',
                    description:
                        '現在地を警報地域とする緊急地震速報(警報)が発表されたときに、おやすみモードやマナーモードを無視して強制的に通知を配信します。',
                    decision: state.criticalAlert,
                    isEnabled: !isProcessing && state.canRequestCriticalAlert,
                    disabledReason: state.canRequestCriticalAlert
                        ? null
                        : '先に通知を許可してください',
                    onSkip: () => permissionFlow.skipCriticalAlert(ref),
                    onAllow: () =>
                        permissionFlow.requestCriticalAlert(ref, context),
                  ),
                ],
              ],
            ),
            SizedBox(height: designSystem.spacing.xl),
            _PermissionSection(
              title: '2. 位置情報権限',
              description: Text.rich(
                TextSpan(
                  style: designSystem.typography.bodySmall.copyWith(
                    color: designSystem.colorTheme.onSurfaceVariant,
                  ),
                  children: [
                    const TextSpan(text: '端末の位置情報を利用して、適した通知をお知らせします。\n'),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: _InlineTextLink(
                        label: 'EQMonitorにおける位置情報の扱い方',
                        onTap: () => openWebView(title: '位置情報の扱い方'),
                      ),
                    ),
                  ],
                ),
              ),
              children: [
                _PermissionActionCard(
                  title: 'アプリを開いている時の位置情報',
                  description:
                      '緊急地震速報発表時に現在地の予想震度と到達までの時間を表示します。気象庁が現在地の予想震度と到達予想時刻を発表した場合に限ります。詳しい情報\n地震情報を開いた時に、現在地付近で観測した震度を表示します',
                  decision: state.foregroundLocation,
                  isEnabled: !isProcessing,
                  onSkip: () => permissionFlow.skipForegroundLocation(ref),
                  onAllow: () =>
                      permissionFlow.requestForegroundLocation(ref, context),
                  linkLabel: '詳しい情報',
                  onLinkTap: () => openWebView(title: '緊急地震速報の詳しい情報'),
                ),
                SizedBox(height: designSystem.spacing.md),
                _PermissionActionCard(
                  title: 'アプリを開いていない時の位置情報',
                  description:
                      '現在地で緊急地震速報(警報)が発表された時に重大な通知でお知らせします。\n注意!: 高速で移動している場合やネットワーク環境が悪い場合、低電力モードにしている場合、前の位置情報で通知が配信される場合があります。\n現在地で揺れを観測した地震情報が発表された場合のみ通知することができます。この後の通知設定で細かく設定できます',
                  decision: state.backgroundLocation,
                  isEnabled:
                      !isProcessing && state.canRequestBackgroundLocation,
                  disabledReason: state.canRequestBackgroundLocation
                      ? null
                      : '先にアプリ使用中の位置情報を許可してください',
                  onSkip: () => permissionFlow.skipBackgroundLocation(ref),
                  onAllow: () =>
                      permissionFlow.requestBackgroundLocation(ref, context),
                ),
              ],
            ),
            SizedBox(height: designSystem.spacing.xl),
          ],
        ),
      ),
    );
  }
}

bool _isPermissionRequestProcessing(WidgetRef ref) {
  return ref.watch(PermissionNotifier.requestNotificationMutation)
          is MutationPending ||
      ref.watch(PermissionNotifier.requestCriticalAlertMutation)
          is MutationPending ||
      ref.watch(PermissionNotifier.requestForegroundLocationMutation)
          is MutationPending ||
      ref.watch(PermissionNotifier.requestBackgroundLocationMutation)
          is MutationPending;
}

class _PermissionSection extends StatelessWidget {
  const _PermissionSection({
    required this.title,
    required this.children,
    this.description,
  });

  final String title;
  final Widget? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: designSystem.typography.titleLarge),
        if (description case final description?) ...[
          SizedBox(height: designSystem.spacing.sm),
          DefaultTextStyle(
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
            child: description,
          ),
        ],
        SizedBox(height: designSystem.spacing.md),
        ...children,
      ],
    );
  }
}

class _PermissionActionCard extends StatelessWidget {
  const _PermissionActionCard({
    required this.title,
    required this.description,
    required this.decision,
    required this.isEnabled,
    required this.onSkip,
    required this.onAllow,
    this.disabledReason,
    this.linkLabel,
    this.onLinkTap,
  });

  final String title;
  final String description;
  final PermissionItemDecision decision;
  final bool isEnabled;
  final VoidCallback onSkip;
  final Future<void> Function() onAllow;
  final String? disabledReason;
  final String? linkLabel;
  final VoidCallback? onLinkTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final isGranted = decision == PermissionItemDecision.granted;
    final isSkipped = decision == PermissionItemDecision.skipped;
    final actionButtons = isGranted
        ? const [_GrantedPermissionChip()]
        : [
            TextButton(
              onPressed: isSkipped || !isEnabled ? null : onSkip,
              child: Text(isSkipped ? 'スキップしました' : 'スキップ'),
            ),
            FilledButton(
              onPressed: isSkipped || !isEnabled ? null : onAllow,
              child: const Text('許可する'),
            ),
          ];

    return Container(
      padding: EdgeInsets.all(designSystem.spacing.md),
      decoration: BoxDecoration(
        color: designSystem.colorTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        border: Border.all(color: designSystem.colorTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: designSystem.typography.titleMedium),
          SizedBox(height: designSystem.spacing.sm),
          _PermissionDescriptionText(
            description: description,
            linkLabel: linkLabel,
            onLinkTap: onLinkTap,
          ),
          if (disabledReason != null && !isEnabled && !isSkipped) ...[
            SizedBox(height: designSystem.spacing.sm),
            Text(
              disabledReason!,
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.colorTheme.outline,
              ),
            ),
          ],
          SizedBox(height: designSystem.spacing.md),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: designSystem.spacing.sm,
            runSpacing: designSystem.spacing.sm,
            children: actionButtons,
          ),
        ],
      ),
    );
  }
}

class _PermissionDescriptionText extends StatelessWidget {
  const _PermissionDescriptionText({
    required this.description,
    required this.linkLabel,
    required this.onLinkTap,
  });

  final String description;
  final String? linkLabel;
  final VoidCallback? onLinkTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final label = linkLabel;
    final onTap = onLinkTap;
    if (label == null || onTap == null || !description.contains(label)) {
      return Text(
        description,
        style: designSystem.typography.bodySmall.copyWith(
          color: designSystem.colorTheme.onSurfaceVariant,
        ),
      );
    }

    final parts = description.split(label);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: parts.first),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _InlineTextLink(label: label, onTap: onTap),
          ),
          TextSpan(text: parts.length > 1 ? parts[1] : ''),
        ],
      ),
      style: designSystem.typography.bodySmall.copyWith(
        color: designSystem.colorTheme.onSurfaceVariant,
      ),
    );
  }
}

class _InlineTextLink extends StatelessWidget {
  const _InlineTextLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: designSystem.typography.bodySmall.copyWith(
          color: designSystem.colorTheme.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _GrantedPermissionChip extends StatelessWidget {
  const _GrantedPermissionChip();

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Chip(
      avatar: Icon(
        Icons.check_circle_outline,
        color: designSystem.colorTheme.status.success,
      ),
      label: const Text('許可しました'),
    );
  }
}
