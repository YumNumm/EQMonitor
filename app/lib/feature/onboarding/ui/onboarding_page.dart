import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/onboarding/ui/component/onboarding_provisioning_error_details_dialog.dart';
import 'package:eqmonitor/feature/onboarding/ui/onboarding_custom_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _OnboardingStep {
  welcome,
  deviceRegistration,
  permissions,
  notificationSettings,
  complete,
}

enum _PermissionState { notRequested, granted, denied, deniedForever }

enum _NotificationPreset { recommended, custom, advanced }

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  static const List<_OnboardingStep> _steps = _OnboardingStep.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final currentPage = useState(0);
    final isProcessing = useState(false);
    final notificationPermission = useState(_PermissionState.notRequested);
    final locationPermission = useState(_PermissionState.notRequested);
    final selectedPreset = useState<_NotificationPreset?>(null);
    final provisionError = useState<String?>(null);
    final settingsSaveError = useState<String?>(null);
    final registrationTriggered = useState(false);
    final ds = Theme.of(context).designSystemThemeExtension;

    Future<void> animateToNext() async {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }

    Future<void> startProvisioning() async {
      final status = ref.read(deviceProvisioningProvider);
      if (status.value == DeviceProvisioningStatus.notRequired) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        if (context.mounted) {
          await animateToNext();
        }
        return;
      }

      isProcessing.value = true;
      provisionError.value = null;
      try {
        await ref.read(deviceProvisioningProvider.notifier).provision();
        await Future<void>.delayed(const Duration(milliseconds: 500));
        if (context.mounted) {
          isProcessing.value = false;
          await animateToNext();
        }
      } on Exception catch (e) {
        if (context.mounted) {
          isProcessing.value = false;
          provisionError.value = e.toString();
        }
      }
    }

    Future<void> requestPermissions() async {
      isProcessing.value = true;

      // 1. 通知 + 重大な通知
      final messaging = ref.read(firebaseMessagingProvider);
      final settings = await messaging.requestPermission(
        criticalAlert: true,
      );
      final authStatus = settings.authorizationStatus;
      if (authStatus == AuthorizationStatus.authorized ||
          authStatus == AuthorizationStatus.provisional) {
        notificationPermission.value = _PermissionState.granted;
      } else {
        notificationPermission.value = _PermissionState.denied;
      }

      // 2. 位置情報
      var locPerm = await Geolocator.checkPermission();
      if (locPerm == LocationPermission.denied) {
        locPerm = await Geolocator.requestPermission();
      }
      if (locPerm == LocationPermission.whileInUse ||
          locPerm == LocationPermission.always) {
        locationPermission.value = _PermissionState.granted;
      } else if (locPerm == LocationPermission.deniedForever) {
        locationPermission.value = _PermissionState.deniedForever;
      } else {
        locationPermission.value = _PermissionState.denied;
      }

      if (context.mounted) {
        isProcessing.value = false;
        await animateToNext();
      }
    }

    Future<void> saveRecommendedSettings() async {
      isProcessing.value = true;
      settingsSaveError.value = null;
      try {
        // EEW: 現在地, minJmaIntensity=JmaIntensity.four (default)
        await ref.read(eewSettingsProvider.future);
        await ref.read(eewSettingsProvider.notifier).addCurrentLocationRegion();

        // 地震情報: 現在地, minJmaIntensity=JmaIntensity.one
        await ref.read(earthquakeNotificationSettingsProvider.future);
        await ref
            .read(earthquakeNotificationSettingsProvider.notifier)
            .addCurrentLocationRegion(minIntensity: JmaIntensity.one);

        if (context.mounted) {
          isProcessing.value = false;
          await animateToNext();
        }
      } on Exception catch (e) {
        if (context.mounted) {
          isProcessing.value = false;
          settingsSaveError.value = e.toString();
        }
      }
    }

    Future<void> goToNext() async {
      final step = _steps[currentPage.value];

      switch (step) {
        case _OnboardingStep.welcome:
          await animateToNext();

        case _OnboardingStep.deviceRegistration:
          break;

        case _OnboardingStep.permissions:
          if (notificationPermission.value == _PermissionState.notRequested) {
            await requestPermissions();
          } else {
            await animateToNext();
          }

        case _OnboardingStep.notificationSettings:
          switch (selectedPreset.value) {
            case _NotificationPreset.recommended:
            case _NotificationPreset.advanced:
              await saveRecommendedSettings();
            case _NotificationPreset.custom:
              if (context.mounted) {
                await Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => const OnboardingCustomSettingsPage(),
                  ),
                );
                if (context.mounted) {
                  await animateToNext();
                }
              }
            case null:
              break;
          }

        case _OnboardingStep.complete:
          await OnboardingCompleted.completeMutation.run(
            ref,
            (tsx) async =>
                tsx.get(onboardingCompletedProvider.notifier).complete(),
          );
          if (context.mounted) {
            context.go('/');
          }
      }
    }

    Future<void> goToPrevious() async {
      await pageController.previousPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }

    void onPageChanged(int index) {
      currentPage.value = index;
      if (_steps[index] == _OnboardingStep.deviceRegistration &&
          !registrationTriggered.value) {
        registrationTriggered.value = true;
        unawaited(startProvisioning());
      }
    }

    final currentStep = _steps[currentPage.value];

    // ボタンラベル
    final String buttonLabel;
    if (currentStep == _OnboardingStep.complete) {
      buttonLabel = 'はじめる';
    } else if (currentStep == _OnboardingStep.permissions &&
        (notificationPermission.value != _PermissionState.notRequested ||
            locationPermission.value != _PermissionState.notRequested) &&
        (notificationPermission.value != _PermissionState.granted ||
            locationPermission.value != _PermissionState.granted)) {
      buttonLabel = 'スキップ';
    } else {
      buttonLabel = '次へ';
    }

    // 次へボタンの有効/無効
    final bool isNextEnabled;
    if (isProcessing.value) {
      isNextEnabled = false;
    } else {
      switch (currentStep) {
        case _OnboardingStep.welcome:
          isNextEnabled = true;
        case _OnboardingStep.deviceRegistration:
          isNextEnabled = false;
        case _OnboardingStep.permissions:
          isNextEnabled = true;
        case _OnboardingStep.notificationSettings:
          isNextEnabled = selectedPreset.value != null;
        case _OnboardingStep.complete:
          isNextEnabled = true;
      }
    }

    // 戻るボタン表示/有効
    final showBack =
        currentPage.value > 0 && currentStep != _OnboardingStep.complete;
    final isBackEnabled = showBack && !isProcessing.value;

    return Scaffold(
      backgroundColor: ds.color.backgroundDefault,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: onPageChanged,
                itemCount: _steps.length,
                itemBuilder: (context, index) => _StepPage(
                  step: _steps[index],
                  isProcessing: isProcessing.value,
                  provisionError: provisionError.value,
                  onRetryProvision: () {
                    provisionError.value = null;
                    registrationTriggered.value = false;
                    unawaited(startProvisioning());
                  },
                  notificationPermission: notificationPermission.value,
                  locationPermission: locationPermission.value,
                  selectedPreset: selectedPreset.value,
                  settingsSaveError: settingsSaveError.value,
                  onPresetSelected: (preset) => selectedPreset.value = preset,
                ),
              ),
            ),
            _BottomBar(
              currentPage: currentPage.value,
              totalPages: _steps.length,
              buttonLabel: buttonLabel,
              isNextEnabled: isNextEnabled,
              showBack: showBack,
              isBackEnabled: isBackEnabled,
              onNext: goToNext,
              onBack: goToPrevious,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepPage extends StatelessWidget {
  const _StepPage({
    required this.step,
    required this.isProcessing,
    required this.provisionError,
    required this.onRetryProvision,
    required this.notificationPermission,
    required this.locationPermission,
    required this.selectedPreset,
    required this.settingsSaveError,
    required this.onPresetSelected,
  });

  final _OnboardingStep step;
  final bool isProcessing;
  final String? provisionError;
  final VoidCallback onRetryProvision;
  final _PermissionState notificationPermission;
  final _PermissionState locationPermission;
  final _NotificationPreset? selectedPreset;
  final String? settingsSaveError;
  final ValueChanged<_NotificationPreset> onPresetSelected;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      _OnboardingStep.welcome => const _WelcomeStepContent(),
      _OnboardingStep.deviceRegistration => _DeviceRegistrationStepContent(
        isProcessing: isProcessing,
        error: provisionError,
        onRetry: onRetryProvision,
      ),
      _OnboardingStep.permissions => _PermissionsStepContent(
        notificationPermission: notificationPermission,
        locationPermission: locationPermission,
      ),
      _OnboardingStep.notificationSettings => _NotificationSettingsStepContent(
        selectedPreset: selectedPreset,
        onPresetSelected: onPresetSelected,
        saveError: settingsSaveError,
      ),
      _OnboardingStep.complete => const _CompleteStepContent(),
    };
  }
}

// ─────────────────────────────────────────────
// Welcome
// ─────────────────────────────────────────────

class _WelcomeStepContent extends StatelessWidget {
  const _WelcomeStepContent();

  @override
  Widget build(BuildContext context) {
    final ds = Theme.of(context).designSystemThemeExtension;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: ds.spacing.xxxxl),
          Text(
            'EQMonitor へ\nようこそ',
            style: ds.typography.displayMedium,
          ),
          SizedBox(height: ds.spacing.sm),
          Text(
            'リアルタイムの地震情報と\n緊急地震速報をお届けします',
            style: ds.typography.bodyLarge.copyWith(
              color: ds.textColor.secondary,
            ),
          ),
          const Spacer(),
          Center(
            child: _AppIconHero(
              color: ds.palette.brandPrimary,
              backgroundColor: ds.color.surfaceRaised,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Device Registration
// ─────────────────────────────────────────────

class _DeviceRegistrationStepContent extends StatelessWidget {
  const _DeviceRegistrationStepContent({
    required this.isProcessing,
    required this.error,
    required this.onRetry,
  });

  final bool isProcessing;
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final ds = Theme.of(context).designSystemThemeExtension;
    final errorDetails = error;
    final hasError = errorDetails != null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: ds.spacing.xxxxl),
          Text(
            'はじめに',
            style: ds.typography.displayMedium,
          ),
          SizedBox(height: ds.spacing.sm),
          Text(
            hasError ? 'デバイスの登録に失敗しました' : 'サーバーにデバイスを登録しています...',
            style: ds.typography.bodyLarge.copyWith(
              color: hasError
                  ? ds.palette.statusDanger
                  : ds.textColor.secondary,
            ),
          ),
          const Spacer(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: ds.color.surfaceRaised,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: hasError
                        ? Icon(
                            Icons.error_outline_rounded,
                            color: ds.palette.statusDanger,
                            size: 56,
                          )
                        : SizedBox(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(
                              color: ds.palette.brandPrimary,
                              strokeWidth: 3,
                            ),
                          ),
                  ),
                ),
                if (hasError) ...[
                  SizedBox(height: ds.spacing.lg),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: ds.spacing.sm,
                    runSpacing: ds.spacing.sm,
                    children: [
                      FilledButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh_rounded, size: 18),
                        label: const Text('再試行'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () async => showDialog<void>(
                          context: context,
                          builder: (context) =>
                              OnboardingProvisioningErrorDetailsDialog(
                                details: errorDetails,
                              ),
                        ),
                        icon: const Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                        ),
                        label: const Text('詳細情報を見る'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Permissions
// ─────────────────────────────────────────────

class _PermissionsStepContent extends StatelessWidget {
  const _PermissionsStepContent({
    required this.notificationPermission,
    required this.locationPermission,
  });

  final _PermissionState notificationPermission;
  final _PermissionState locationPermission;

  @override
  Widget build(BuildContext context) {
    final ds = Theme.of(context).designSystemThemeExtension;
    final anyDenied =
        notificationPermission == _PermissionState.denied ||
        notificationPermission == _PermissionState.deniedForever ||
        locationPermission == _PermissionState.denied ||
        locationPermission == _PermissionState.deniedForever;
    final anyDeniedForever =
        notificationPermission == _PermissionState.deniedForever ||
        locationPermission == _PermissionState.deniedForever;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: ds.spacing.xxxxl),
          Text(
            '通知と\n位置情報',
            style: ds.typography.displayMedium,
          ),
          SizedBox(height: ds.spacing.sm),
          Text(
            '緊急地震速報や地震情報をリアルタイムに受け取るために、'
            '通知と位置情報を許可してください',
            style: ds.typography.bodyLarge.copyWith(
              color: ds.textColor.secondary,
            ),
          ),
          if (anyDenied) ...[
            SizedBox(height: ds.spacing.sm),
            Text(
              '設定アプリからいつでも変更できます',
              style: ds.typography.bodySmall.copyWith(
                color: ds.textColor.tertiary,
              ),
            ),
            if (anyDeniedForever) ...[
              SizedBox(height: ds.spacing.sm),
              OutlinedButton.icon(
                onPressed: () async => Geolocator.openAppSettings(),
                icon: const Icon(Icons.settings_outlined, size: 18),
                label: const Text('設定アプリを開く'),
              ),
            ],
          ],
          const Spacer(),
          Center(
            child: _PermissionsHero(
              color: ds.palette.brandPrimary,
              backgroundColor: ds.color.surfaceRaised,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Notification Settings
// ─────────────────────────────────────────────

class _NotificationSettingsStepContent extends StatelessWidget {
  const _NotificationSettingsStepContent({
    required this.selectedPreset,
    required this.onPresetSelected,
    required this.saveError,
  });

  final _NotificationPreset? selectedPreset;
  final ValueChanged<_NotificationPreset> onPresetSelected;
  final String? saveError;

  @override
  Widget build(BuildContext context) {
    final ds = Theme.of(context).designSystemThemeExtension;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.lg),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: ds.spacing.xxxxl),
            Text(
              '通知設定',
              style: ds.typography.displayMedium,
            ),
            SizedBox(height: ds.spacing.sm),
            Text(
              '細かい設定は後からでも変更できます',
              style: ds.typography.bodySmall.copyWith(
                color: ds.textColor.tertiary,
              ),
            ),
            SizedBox(height: ds.spacing.xl),

            // 推奨設定
            _PresetCard(
              title: '推奨設定',
              isSelected: selectedPreset == _NotificationPreset.recommended,
              onTap: () => onPresetSelected(_NotificationPreset.recommended),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BulletItem(
                    text: '現在地の緊急地震速報(警報)',
                    ds: ds,
                  ),
                  _BulletItem(
                    text: '現在地で予想震度4以上の緊急地震速報(予報)',
                    ds: ds,
                  ),
                  _BulletItem(
                    text: '現在地で震度1以上を観測',
                    ds: ds,
                  ),
                ],
              ),
            ),
            SizedBox(height: ds.spacing.md),

            // カスタム
            _PresetCard(
              title: 'カスタム',
              isSelected: selectedPreset == _NotificationPreset.custom,
              onTap: () => onPresetSelected(_NotificationPreset.custom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BulletItem(
                    text: '緊急地震速報と地震情報について、追加で1地域まで指定',
                    ds: ds,
                  ),
                  _BulletItem(
                    text: '現在地の緊急地震速報(警報)有無',
                    ds: ds,
                  ),
                ],
              ),
            ),
            SizedBox(height: ds.spacing.md),

            // 高度な設定 [PRO]
            // TODO: 課金状態の判定を実装。無課金時はグレーアウトする
            _PresetCard(
              title: '高度な設定',
              badge: 'PRO',
              isSelected: selectedPreset == _NotificationPreset.advanced,
              onTap: () => onPresetSelected(_NotificationPreset.advanced),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BulletItem(
                    text: '緊急地震速報と地震情報について、追加で最大5地域まで指定',
                    ds: ds,
                  ),
                  _BulletItem(
                    text: '予想震度や観測震度に合わせた通知音・通知割り込みレベルのカスタマイズ',
                    ds: ds,
                  ),
                  SizedBox(height: ds.spacing.sm),
                  // TODO: 課金画面への遷移を実装
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('課金について見る'),
                  ),
                ],
              ),
            ),

            if (saveError != null) ...[
              SizedBox(height: ds.spacing.md),
              Text(
                '設定の保存に失敗しました。もう一度お試しください。',
                style: ds.typography.bodySmall.copyWith(
                  color: ds.palette.statusDanger,
                ),
              ),
            ],
            SizedBox(height: ds.spacing.xl),
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
    final ds = Theme.of(context).designSystemThemeExtension;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.all(ds.spacing.md),
        decoration: BoxDecoration(
          color: ds.color.surfaceCard,
          borderRadius: BorderRadius.circular(ds.shape.card),
          border: Border.all(
            color: isSelected ? ds.palette.brandPrimary : ds.color.outlineSoft,
            width: isSelected ? 2 : 1,
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
                      ? ds.palette.brandPrimary
                      : ds.textColor.tertiary,
                  size: 20,
                ),
                SizedBox(width: ds.spacing.sm),
                Text(
                  title,
                  style: ds.typography.titleMedium.copyWith(
                    color: isSelected
                        ? ds.palette.brandPrimary
                        : ds.textColor.primary,
                  ),
                ),
                if (badge != null) ...[
                  SizedBox(width: ds.spacing.xs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ds.spacing.xs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: ds.palette.brandPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      badge!,
                      style: ds.typography.labelSmall.copyWith(
                        color: ds.palette.brandPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: ds.spacing.sm),
            Padding(
              padding: EdgeInsets.only(left: ds.spacing.lg + ds.spacing.xs),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.text, required this.ds});

  final String text;
  final DesignSystemThemeExtension ds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ds.spacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '・',
            style: ds.typography.bodySmall.copyWith(
              color: ds.textColor.secondary,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: ds.typography.bodySmall.copyWith(
                color: ds.textColor.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Complete
// ─────────────────────────────────────────────

class _CompleteStepContent extends StatelessWidget {
  const _CompleteStepContent();

  @override
  Widget build(BuildContext context) {
    final ds = Theme.of(context).designSystemThemeExtension;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: ds.spacing.xxxxl),
          Text(
            '準備完了',
            style: ds.typography.displayMedium,
          ),
          SizedBox(height: ds.spacing.sm),
          Text(
            'EQMonitor で日本の地震情報をリアルタイムに確認できます',
            style: ds.typography.bodyLarge.copyWith(
              color: ds.textColor.secondary,
            ),
          ),
          const Spacer(),
          Center(
            child: _CompleteHero(
              color: ds.palette.statusSuccess,
              backgroundColor: ds.color.surfaceRaised,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Hero Visuals
// ─────────────────────────────────────────────

class _AppIconHero extends StatelessWidget {
  const _AppIconHero({
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Image.asset(
          Assets.images.icon.path,
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}

class _PermissionsHero extends StatelessWidget {
  const _PermissionsHero({
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _PulseRing(color: color, radius: 90, opacity: 0.08),
          _PulseRing(color: color, radius: 70, opacity: 0.12),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active_rounded,
                  color: color,
                  size: 32,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.location_on_rounded,
                  color: color,
                  size: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseRing extends StatelessWidget {
  const _PulseRing({
    required this.color,
    required this.radius,
    required this.opacity,
  });

  final Color color;
  final double radius;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: opacity), width: 2),
      ),
    );
  }
}

class _CompleteHero extends StatelessWidget {
  const _CompleteHero({
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_rounded,
        color: color,
        size: 80,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bottom Bar
// ─────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.currentPage,
    required this.totalPages,
    required this.buttonLabel,
    required this.isNextEnabled,
    required this.showBack,
    required this.isBackEnabled,
    required this.onNext,
    required this.onBack,
  });

  final int currentPage;
  final int totalPages;
  final String buttonLabel;
  final bool isNextEnabled;
  final bool showBack;
  final bool isBackEnabled;
  final Future<void> Function() onNext;
  final Future<void> Function() onBack;

  @override
  Widget build(BuildContext context) {
    final ds = Theme.of(context).designSystemThemeExtension;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ds.spacing.lg,
        ds.spacing.xl,
        ds.spacing.lg,
        ds.spacing.xxl,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => _PageDot(
                isActive: index == currentPage,
                color: ds.palette.brandPrimary,
                inactiveColor: ds.color.outlineSoft,
              ),
            ),
          ),
          SizedBox(height: ds.spacing.xxl),
          Row(
            children: [
              if (showBack) ...[
                SizedBox(
                  height: 52,
                  child: TextButton(
                    onPressed: isBackEnabled ? onBack : null,
                    child: const Text('戻る'),
                  ),
                ),
                SizedBox(width: ds.spacing.md),
              ],
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: FilledButton(
                    onPressed: isNextEnabled ? onNext : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: ds.palette.brandPrimary,
                      foregroundColor: ds.textColor.inverse,
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(ds.shape.button),
                      ),
                    ),
                    child: Text(
                      buttonLabel,
                      style: ds.typography.labelLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageDot extends StatelessWidget {
  const _PageDot({
    required this.isActive,
    required this.color,
    required this.inactiveColor,
  });

  final bool isActive;
  final Color color;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? color : inactiveColor,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
