import 'package:eqmonitor/feature/permission/data/notifier/permission_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_permission_flow.g.dart';

@riverpod
OnboardingPermissionFlow onboardingPermissionFlow(Ref ref) =>
    OnboardingPermissionFlow();

/// オンボーディングの権限ステップから呼ばれる Flow。
class OnboardingPermissionFlow {
  Future<void> requestNotification(WidgetRef ref, BuildContext context) async {
    final isGranted = await PermissionNotifier.requestNotificationMutation.run(
      ref,
      (transaction) async => transaction
          .get(permissionProvider.notifier)
          .requestNotification(),
    );
    if (!context.mounted || isGranted) {
      return;
    }
    _showPermissionDeniedSnackBar(context);
  }

  Future<void> requestCriticalAlert(WidgetRef ref, BuildContext context) async {
    final isGranted =
        await PermissionNotifier.requestCriticalAlertMutation.run(
          ref,
          (transaction) async => transaction
              .get(permissionProvider.notifier)
              .requestCriticalAlert(),
        );
    if (!context.mounted || isGranted) {
      return;
    }
    _showPermissionDeniedSnackBar(context);
  }

  Future<void> requestForegroundLocation(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final isGranted =
        await PermissionNotifier.requestForegroundLocationMutation.run(
          ref,
          (transaction) async => transaction
              .get(permissionProvider.notifier)
              .requestForegroundLocation(),
        );
    if (!context.mounted || isGranted) {
      return;
    }
    _showPermissionDeniedSnackBar(context);
  }

  Future<void> requestBackgroundLocation(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final isGranted =
        await PermissionNotifier.requestBackgroundLocationMutation.run(
          ref,
          (transaction) async => transaction
              .get(permissionProvider.notifier)
              .requestBackgroundLocation(),
        );
    if (!context.mounted || isGranted) {
      return;
    }
    _showPermissionDeniedSnackBar(context);
  }

  void skipNotification(WidgetRef ref) {
    ref.read(permissionProvider.notifier).skipNotification();
  }

  void skipCriticalAlert(WidgetRef ref) {
    ref.read(permissionProvider.notifier).skipCriticalAlert();
  }

  void skipForegroundLocation(WidgetRef ref) {
    ref.read(permissionProvider.notifier).skipForegroundLocation();
  }

  void skipBackgroundLocation(WidgetRef ref) {
    ref.read(permissionProvider.notifier).skipBackgroundLocation();
  }

  void _showPermissionDeniedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('権限が許可されませんでした。必要になったら設定から変更できます。')),
    );
  }
}
