library;

import 'dart:async';

import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart';
import 'package:eqmonitor/feature/permission/data/flow/onboarding_permission_flow.dart';
import 'package:eqmonitor/feature/permission/data/notifier/permission_notifier.dart';
import 'package:eqmonitor/feature/permission/data/provider/permission_request_processing_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
import 'package:eqmonitor/feature/start/data/notifier/update_banner_seen_version_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

part '../components/complete_step_page.dart';
part '../components/notification_settings_step_page.dart';
part '../components/onboarding_bottom_bar.dart';
part '../components/onboarding_hero.dart';
part '../components/onboarding_step_page.dart';
part '../components/permissions_step_page.dart';
part '../components/welcome_step_page.dart';
part '../model/onboarding_step.dart';

typedef _OnboardingNavigationRegistrar = void Function(
  _StepNavigationState state,
);

class _OnboardingStepNavigation {
  const new({
    required this.isActive,
    required this.nextPage,
    required this.previousPage,
    required this.register,
  });

  final bool isActive;
  final Future<void> Function() nextPage;
  final Future<void> Function() previousPage;
  final _OnboardingNavigationRegistrar register;
}

class OnboardingPage extends HookConsumerWidget {
  const new({super.key});

  static const List<_OnboardingStep> _steps = _OnboardingStep.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final currentPage = useState(0);
    final stepNavigation = useState(_StepNavigationState.initial(_steps.first));

    final animateToNext = useCallback<Future<void> Function()>(() async {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }, [pageController]);

    final goToPrevious = useCallback<Future<void> Function()>(() async {
      await pageController.previousPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }, [pageController]);

    final currentStep = _steps[currentPage.value];

    // _steps と同じ順序・要素数で構築するため、index アクセスは常に成立する。
    final stepControls = [
      for (final step in _steps)
        _OnboardingStepNavigation(
          isActive: currentStep == step,
          nextPage: animateToNext,
          previousPage: goToPrevious,
          register: (state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted || step != _steps[currentPage.value]) {
                return;
              }
              stepNavigation.value = state;
            });
          },
        ),
    ];

    void onPageChanged(int index) {
      currentPage.value = index;
      stepNavigation.value = _StepNavigationState.initial(_steps[index]);
    }

    final navigation = stepNavigation.value;

    final showBack =
        currentPage.value > 0 && currentStep != _OnboardingStep.complete;
    final isBackEnabled = showBack && !navigation.isProcessing;

    Future<void> goToNext() async {
      unawaited(HapticFeedback.mediumImpact());
      await stepNavigation.value.onNext?.call();
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          unawaited(goToPrevious());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: onPageChanged,
                  itemCount: _steps.length,
                  itemBuilder: (context, index) => _OnboardingStepPage(
                    step: _steps[index],
                    navigation: stepControls[index],
                  ),
                ),
              ),
              _OnboardingBottomBar(
                currentPage: currentPage.value,
                totalPages: _steps.length,
                buttonLabel: navigation.buttonLabel,
                processingLabel: navigation.processingLabel,
                isNextEnabled: navigation.isNextEnabled,
                isBackEnabled: isBackEnabled,
                isProcessing: navigation.isProcessing,
                onNext: goToNext,
                onPrevious: showBack ? goToPrevious : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepNavigationState {
  const new({
    required this.buttonLabel,
    required this.processingLabel,
    required this.isNextEnabled,
    required this.isProcessing,
    required this.onNext,
  });

  factory initial(_OnboardingStep step) => _StepNavigationState(
    buttonLabel: switch (step) {
      _OnboardingStep.complete => 'はじめる',
      _ => '次へ',
    },
    processingLabel: '処理しています...',
    isNextEnabled: switch (step) {
      _OnboardingStep.welcome => false,
      _OnboardingStep.permissions => false,
      _OnboardingStep.notificationSettings => false,
      _OnboardingStep.complete => false,
    },
    isProcessing: false,
    onNext: null,
  );

  final String buttonLabel;
  final String processingLabel;
  final bool isNextEnabled;
  final bool isProcessing;
  final Future<void> Function()? onNext;
}
