part of '../page/onboarding_page.dart';

class _WelcomeStepPage extends HookConsumerWidget {
  const _WelcomeStepPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scope = _OnboardingScope.of(context);
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final deviceProvisioningStatus = ref.watch(deviceProvisioningProvider);
    final deviceProvisioningMutation = ref.watch(
      DeviceProvisioningNotifier.provisionMutation,
    );
    final isProvisioned =
        deviceProvisioningStatus.value == .notRequired ||
        deviceProvisioningMutation is MutationSuccess;
    final isProcessing =
        deviceProvisioningStatus.isLoading ||
        deviceProvisioningMutation is MutationPending;

    Future<void> startProvisioning() async {
      await DeviceProvisioningNotifier.provisionMutation.run(
        ref,
        (tsx) async => tsx.get(deviceProvisioningProvider.notifier).provision(),
      );
    }

    void retryProvisioning() {
      ref.read(deviceProvisioningProvider.notifier).reset();
      unawaited(startProvisioning());
    }

    ref.listen(deviceProvisioningProvider, (_, next) {
      if (next case AsyncError(:final error)) {
        unawaited(
          _showDeviceRegistrationErrorDialog(
            context: context,
            message: 'デバイスの状態確認に失敗しました',
            details: error.toString(),
            onRetry: retryProvisioning,
          ),
        );
      }
    });

    ref.listen(DeviceProvisioningNotifier.provisionMutation, (_, next) {
      if (next is MutationError) {
        final errorMessage = switch (next.error) {
          DeviceProvisioningException(:final userMessage) => userMessage,
          _ => next.error.toString(),
        };
        unawaited(
          _showDeviceRegistrationErrorDialog(
            context: context,
            message: errorMessage,
            details: next.error.toString(),
            onRetry: retryProvisioning,
          ),
        );
      }
    });

    useEffect(
      () {
        if (deviceProvisioningStatus.value == .required &&
            deviceProvisioningMutation is MutationIdle) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) {
              return;
            }
            unawaited(startProvisioning());
          });
        }
        return null;
      },
      [
        deviceProvisioningStatus,
        deviceProvisioningMutation,
      ],
    );

    useEffect(() {
      scope.setStepNavigation(
        step: _OnboardingStep.welcome,
        state: _StepNavigationState(
          buttonLabel: '次へ',
          isNextEnabled: isProvisioned,
          isProcessing: isProcessing,
          onNext: scope.nextPage,
        ),
      );
      return null;
    }, [scope, isProvisioned, isProcessing]);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: designSystem.spacing.xxxxl),
          Text(
            'EQMonitor へ\nようこそ',
            style: designSystem.typography.displayMedium,
          ),
          SizedBox(height: designSystem.spacing.sm),
          Text(
            'リアルタイムの地震情報と\n緊急地震速報をお届けします',
            style: designSystem.typography.bodyLarge.copyWith(
              color: designSystem.textColor.secondary,
            ),
          ),
          const Spacer(),
          const Center(child: _OnboardingAppIconHero()),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

Future<void> _showDeviceRegistrationErrorDialog({
  required BuildContext context,
  required String message,
  required String details,
  required VoidCallback onRetry,
}) async {
  if (!context.mounted) {
    return;
  }
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('デバイスの登録に失敗しました'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onRetry();
          },
          child: const Text('再試行'),
        ),
        TextButton(
          onPressed: () async => showDialog<void>(
            context: context,
            builder: (context) =>
                OnboardingProvisioningErrorDetailsDialog(details: details),
          ),
          child: const Text('詳細'),
        ),
      ],
    ),
  );
}
