part of '../page/onboarding_page.dart';

class _WelcomeStepPage extends HookConsumerWidget {
  const _WelcomeStepPage({required this.navigation});

  final _OnboardingStepNavigation navigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final deviceProvisioningStatus = ref.watch(deviceProvisioningProvider);
    final deviceProvisioningMutation = ref.watch(
      DeviceProvisioningNotifier.provisionMutation,
    );
    final isProvisioned =
        deviceProvisioningStatus.value == .notRequired ||
        deviceProvisioningMutation is MutationSuccess;
    final isRegisteringDevice = deviceProvisioningMutation is MutationPending;
    final isProcessing =
        deviceProvisioningStatus.isLoading || isRegisteringDevice;
    final processingLabel = isRegisteringDevice
        ? 'デバイスを登録しています...'
        : 'デバイスの状態を確認しています...';

    Future<void> startProvisioning() async {
      try {
        await DeviceProvisioningNotifier.provisionMutation.run(
          ref,
          (tsx) async =>
              tsx.get(deviceProvisioningProvider.notifier).provision(),
        );
      } on Exception {
        // MutationError is observed by ref.listen and shown in a dialog.
      }
    }

    void retryProvisioning() {
      ref.read(deviceProvisioningProvider.notifier).reset();
      unawaited(startProvisioning());
    }

    ref.listen(deviceProvisioningProvider, (_, next) {
      if (next case AsyncError(:final error, :final stackTrace)) {
        unawaited(
          _showDeviceRegistrationErrorDialog(
            context: context,
            message: 'デバイスの状態確認に失敗しました',
            error: error,
            stackTrace: stackTrace,
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
            error: next.error,
            stackTrace: next.stackTrace,
            onRetry: retryProvisioning,
          ),
        );
      }
    });

    useEffect(() {
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
    }, [deviceProvisioningStatus, deviceProvisioningMutation]);

    useEffect(() {
      if (!navigation.isActive) {
        return null;
      }
      if (deviceProvisioningStatus.isLoading &&
          deviceProvisioningMutation is MutationIdle) {
        return null;
      }
      navigation.register(
        _StepNavigationState(
          buttonLabel: '次へ',
          processingLabel: processingLabel,
          isNextEnabled: isProvisioned,
          isProcessing: isProcessing,
          onNext: navigation.nextPage,
        ),
      );
      return null;
    }, [
      navigation,
      navigation.isActive,
      isProvisioned,
      isProcessing,
      processingLabel,
    ]);

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
              color: designSystem.colorTheme.onSurfaceVariant,
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
  required Object error,
  required StackTrace? stackTrace,
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
          onPressed: () => showErrorDetailsSheet(
            context,
            error: error,
            stackTrace: stackTrace,
          ),
          child: const Text('詳細'),
        ),
      ],
    ),
  );
}
