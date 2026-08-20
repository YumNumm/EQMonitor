library;

import 'dart:async';

import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/onboarding/data/flow/complete_onboarding_flow.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart';
import 'package:eqmonitor/feature/permission/data/flow/onboarding_permission_flow.dart';
import 'package:eqmonitor/feature/permission/data/notifier/permission_notifier.dart';
import 'package:eqmonitor/feature/permission/data/provider/permission_request_processing_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
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
    // 描画に影響する値だけを useState で持つ。onNext は毎ビルド新しいクロージャに
    // なるため useRef に置き、識別子の変化で再ビルドを誘発しないようにする。
    final stepView = useState(_StepNavigationView.initial(_steps.first));
    final onNextRef = useRef<Future<void> Function()?>(null);

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
            if (step != _steps[currentPage.value]) {
              return;
            }
            // onNext は常に最新へ差し替える。useRef なのでここでは再ビルドしない。
            onNextRef.value = state.onNext;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted || step != _steps[currentPage.value]) {
                return;
              }
              stepView.value = state.view;
            });
          },
        ),
    ];

    void onPageChanged(int index) {
      currentPage.value = index;
      onNextRef.value = null;
      stepView.value = _StepNavigationView.initial(_steps[index]);
    }

    final view = stepView.value;

    final showBack =
        currentPage.value > 0 && currentStep != _OnboardingStep.complete;
    final isBackEnabled = showBack && !view.isProcessing;

    Future<void> goToNext() async {
      final onNext = onNextRef.value;
      if (onNext == null) {
        return;
      }
      unawaited(HapticFeedback.mediumImpact());
      await onNext();
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
                buttonLabel: view.buttonLabel,
                processingLabel: view.processingLabel,
                // hasNext を含めることで、まだ onNext が登録されていない間に
                // 「押せるのに何も起きない」ボタンが生まれないようにする。
                isNextEnabled: view.isNextEnabled && view.hasNext,
                isBackEnabled: isBackEnabled,
                isProcessing: view.isProcessing,
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

/// 各ステップが [_OnboardingStepNavigation.register] に渡す状態。
class _StepNavigationState {
  const new({
    required this.buttonLabel,
    required this.processingLabel,
    required this.isNextEnabled,
    required this.isProcessing,
    required this.onNext,
  });

  final String buttonLabel;
  final String processingLabel;
  final bool isNextEnabled;
  final bool isProcessing;
  final Future<void> Function()? onNext;

  _StepNavigationView get view => _StepNavigationView(
    buttonLabel: buttonLabel,
    processingLabel: processingLabel,
    isNextEnabled: isNextEnabled,
    isProcessing: isProcessing,
    hasNext: onNext != null,
  );
}

/// ボトムバーの描画に必要な値だけを持つ不変ビュー。
///
/// クロージャを含めず値等価を実装しているのが要点。含めてしまうと毎ビルド
/// 新しいクロージャで不等になり、`register` → post-frame → `useState` 更新 →
/// 再ビルド → `register` … のループでフレームを永久にスケジュールし続ける。
class _StepNavigationView {
  const new({
    required this.buttonLabel,
    required this.processingLabel,
    required this.isNextEnabled,
    required this.isProcessing,
    required this.hasNext,
  });

  factory initial(_OnboardingStep step) => _StepNavigationView(
    buttonLabel: switch (step) {
      _OnboardingStep.complete => 'はじめる',
      _ => '次へ',
    },
    processingLabel: '処理しています...',
    isNextEnabled: false,
    isProcessing: false,
    hasNext: false,
  );

  final String buttonLabel;
  final String processingLabel;
  final bool isNextEnabled;
  final bool isProcessing;

  /// 有効な `onNext` が登録済みかどうか。
  final bool hasNext;

  @override
  bool operator ==(Object other) =>
      other is _StepNavigationView &&
      other.buttonLabel == buttonLabel &&
      other.processingLabel == processingLabel &&
      other.isNextEnabled == isNextEnabled &&
      other.isProcessing == isProcessing &&
      other.hasNext == hasNext;

  @override
  int get hashCode => Object.hash(
    buttonLabel,
    processingLabel,
    isNextEnabled,
    isProcessing,
    hasNext,
  );
}
