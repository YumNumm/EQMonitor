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
    // 失敗を画面上にも残す。ダイアログを閉じても再試行できないと、
    // provisionMutation が MutationError のまま自動再試行の条件
    // (MutationIdle) を満たさず、無効な「次へ」だけが残って詰む。
    final failureMessage = switch (deviceProvisioningMutation) {
      MutationError(:final error) => const DeviceProvisioningErrorMessage().of(
        error,
      ),
      _ => deviceProvisioningStatus is AsyncError ? 'デバイスの状態確認に失敗しました' : null,
    };

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
        unawaited(
          DeviceRegistrationErrorDialogAction().show(
            context: context,
            ref: ref,
            message: const DeviceProvisioningErrorMessage().of(next.error),
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
          // 失敗時は装飾のヒーローより再試行の導線を優先する。差し替えることで
          // 縦方向の高さが増えず、小さい画面でも溢れない。
          if (failureMessage != null)
            _DeviceProvisioningFailureCard(
              message: failureMessage,
              onRetry: retryProvisioning,
            )
          else
            const Center(child: _OnboardingAppIconHero()),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

/// プロビジョニングの失敗を UI 表示用の文言へ変換する。
class DeviceProvisioningErrorMessage {
  const new();

  String of(Object error) => switch (error) {
    DeviceProvisioningException(:final userMessage) => userMessage,
    _ => error.toString(),
  };
}

/// デバイス登録に失敗したことを画面上に残し、再試行の導線を提供するカード。
class _DeviceProvisioningFailureCard extends StatelessWidget {
  const new({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Container(
      padding: EdgeInsets.all(designSystem.spacing.md),
      decoration: BoxDecoration(
        color: designSystem.colorTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        border: Border.all(
          color: designSystem.colorTheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: designSystem.colorTheme.error,
              ),
              SizedBox(width: designSystem.spacing.sm),
              Expanded(
                child: Text(
                  'デバイスの登録に失敗しました',
                  style: designSystem.typography.titleSmall,
                ),
              ),
            ],
          ),
          SizedBox(height: designSystem.spacing.sm),
          Text(
            message,
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: designSystem.spacing.sm),
          Align(
            alignment: .centerRight,
            child: TextButton(onPressed: onRetry, child: const Text('再試行')),
          ),
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
