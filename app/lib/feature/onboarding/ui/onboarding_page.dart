import 'dart:async';

import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _OnboardingStep { welcome, notification, complete }

enum _PermissionStatus { notRequested, granted, denied }

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final currentPage = useState(0);
    final permissionStatus = useState(_PermissionStatus.notRequested);
    final ds = Theme.of(context).designSystemThemeExtension;

    const steps = [
      _OnboardingStep.welcome,
      _OnboardingStep.notification,
      _OnboardingStep.complete,
    ];

    Future<void> goToNext() async {
      final step = steps[currentPage.value];

      if (step == _OnboardingStep.notification &&
          permissionStatus.value == _PermissionStatus.notRequested) {
        final messaging = ref.read(firebaseMessagingProvider);
        final settings = await messaging.requestPermission();
        final status = settings.authorizationStatus;
        if (status == AuthorizationStatus.authorized ||
            status == AuthorizationStatus.provisional) {
          permissionStatus.value = _PermissionStatus.granted;
        } else {
          permissionStatus.value = _PermissionStatus.denied;
          return;
        }
      }

      if (currentPage.value == steps.length - 1) {
        await ref.read(onboardingCompletedProvider.notifier).complete();
        if (context.mounted) {
          context.go('/');
        }
        return;
      }

      unawaited(
        pageController.nextPage(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
        ),
      );
    }

    return Scaffold(
      backgroundColor: ds.color.backgroundDefault,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) => currentPage.value = index,
                itemCount: steps.length,
                itemBuilder: (context, index) => _StepPage(
                  step: steps[index],
                  permissionStatus: permissionStatus.value,
                ),
              ),
            ),
            _BottomBar(
              currentPage: currentPage.value,
              totalPages: steps.length,
              isLast: currentPage.value == steps.length - 1,
              onNext: goToNext,
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
    required this.permissionStatus,
  });

  final _OnboardingStep step;
  final _PermissionStatus permissionStatus;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      _OnboardingStep.welcome => const _WelcomeStepContent(),
      _OnboardingStep.notification => _NotificationStepContent(
        permissionStatus: permissionStatus,
      ),
      _OnboardingStep.complete => const _CompleteStepContent(),
    };
  }
}

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

class _NotificationStepContent extends StatelessWidget {
  const _NotificationStepContent({required this.permissionStatus});

  final _PermissionStatus permissionStatus;

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
            '通知を\n受け取ろう',
            style: ds.typography.displayMedium,
          ),
          SizedBox(height: ds.spacing.sm),
          Text(
            '緊急地震速報や地震情報をすぐに受け取るために、通知を許可してください',
            style: ds.typography.bodyLarge.copyWith(
              color: ds.textColor.secondary,
            ),
          ),
          if (permissionStatus == _PermissionStatus.denied) ...[
            SizedBox(height: ds.spacing.sm),
            Text(
              '通知は設定アプリからいつでも変更できます',
              style: ds.typography.bodySmall.copyWith(
                color: ds.textColor.tertiary,
              ),
            ),
          ],
          const Spacer(),
          Center(
            child: _NotificationHero(
              color: ds.palette.brandPrimary,
              backgroundColor: ds.color.surfaceRaised,
              containerColor: ds.color.surfaceCard,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

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

class _NotificationHero extends StatelessWidget {
  const _NotificationHero({
    required this.color,
    required this.backgroundColor,
    required this.containerColor,
  });

  final Color color;
  final Color backgroundColor;
  final Color containerColor;

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
            child: Icon(
              Icons.notifications_active_rounded,
              color: color,
              size: 52,
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

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.currentPage,
    required this.totalPages,
    required this.isLast,
    required this.onNext,
  });

  final int currentPage;
  final int totalPages;
  final bool isLast;
  final Future<void> Function() onNext;

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
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: () => unawaited(onNext()),
              style: FilledButton.styleFrom(
                backgroundColor: ds.palette.brandPrimary,
                foregroundColor: ds.textColor.inverse,
                shape: RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(ds.shape.button),
                ),
              ),
              child: Text(
                isLast ? 'はじめる' : '次へ',
                style: ds.typography.labelLarge,
              ),
            ),
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
