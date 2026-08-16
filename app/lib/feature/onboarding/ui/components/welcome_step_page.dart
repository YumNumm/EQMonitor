part of '../page/onboarding_page.dart';

class _WelcomeStepPage extends HookConsumerWidget {
  const new({required this.navigation});

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
    final isMigrated =
        ref.watch(deviceMigratedFromLegacyProvider).value ?? false;

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

    Future<void> completeAndGoHome() async {
      await OnboardingCompleted.completeMutation.run(
        ref,
        (tsx) async => tsx.get(onboardingCompletedProvider.notifier).complete(),
      );
      if (context.mounted) {
        const HomeRoute().go(context);
      }
    }

    ref.listen(deviceProvisioningProvider, (_, next) {
      if (next case AsyncError(:final error, :final stackTrace)) {
        unawaited(
          DeviceRegistrationErrorDialogAction().show(
            context: context,
            ref: ref,
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
          DeviceRegistrationErrorDialogAction().show(
            context: context,
            ref: ref,
            message: errorMessage,
            error: next.error,
            stackTrace: next.stackTrace,
            onRetry: retryProvisioning,
          ),
        );
      }
    });

    ref.listen(DeviceProvisioningNotifier.provisionMutation, (_, next) {
      if (next is MutationSuccess) {
        ref.invalidate(deviceMigratedFromLegacyProvider);
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

    useEffect(
      () {
        if (!navigation.isActive) {
          return null;
        }
        if (deviceProvisioningStatus.isLoading &&
            deviceProvisioningMutation is MutationIdle) {
          return null;
        }
        navigation.register(
          _StepNavigationState(
            buttonLabel: isMigrated ? 'はじめる' : '次へ',
            processingLabel: processingLabel,
            isNextEnabled: isProvisioned,
            isProcessing: isProcessing,
            onNext: isMigrated ? completeAndGoHome : navigation.nextPage,
          ),
        );
        return null;
      },
      [
        navigation,
        navigation.isActive,
        isProvisioned,
        isProcessing,
        processingLabel,
        isMigrated,
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: designSystem.spacing.xxxxl),
          Text(
            'EQMonitor へ\nようこそ',
            style: designSystem.typography.displayMedium.copyWith(
              fontFamily: FontFamily.notoSansJP,
              fontWeight: .bold,
            ),
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

/// デバイス登録・状態確認失敗時のエラーダイアログを表示する。
class DeviceRegistrationErrorDialogAction {
  Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
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
            onPressed: () => ref
                .read(errorDetailsSheetActionProvider)
                .show(context, error: error, stackTrace: stackTrace),
            child: const Text('詳細'),
          ),
        ],
      ),
    );
  }
}
