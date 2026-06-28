part of '../page/onboarding_page.dart';

class _PermissionsStepPage extends HookConsumerWidget {
  const _PermissionsStepPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scope = _OnboardingScope.of(context);
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final notificationPermission = useState(_PermissionState.notRequested);
    final locationPermission = useState(_PermissionState.notRequested);
    final isProcessing = useState(false);

    Future<void> requestPermissions() async {
      isProcessing.value = true;

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
        await scope.nextPage();
      }
    }

    Future<void> onNext() async {
      if (notificationPermission.value == _PermissionState.notRequested) {
        await requestPermissions();
        return;
      }
      await scope.nextPage();
    }

    final buttonLabel =
        (notificationPermission.value != _PermissionState.notRequested ||
                locationPermission.value != _PermissionState.notRequested) &&
            (notificationPermission.value != _PermissionState.granted ||
                locationPermission.value != _PermissionState.granted)
        ? 'スキップ'
        : '次へ';

    useEffect(
      () {
        scope.setStepNavigation(
          step: _OnboardingStep.permissions,
          state: _StepNavigationState(
            buttonLabel: buttonLabel,
            isNextEnabled: true,
            isProcessing: isProcessing.value,
            onNext: onNext,
          ),
        );
        return null;
      },
      [
        scope,
        buttonLabel,
        isProcessing.value,
        notificationPermission.value,
        locationPermission.value,
      ],
    );
    final anyDenied =
        notificationPermission.value == _PermissionState.denied ||
        notificationPermission.value == _PermissionState.deniedForever ||
        locationPermission.value == _PermissionState.denied ||
        locationPermission.value == _PermissionState.deniedForever;
    final anyDeniedForever =
        notificationPermission.value == _PermissionState.deniedForever ||
        locationPermission.value == _PermissionState.deniedForever;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: designSystem.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: designSystem.spacing.xxxxl),
          Text(
            '通知と\n位置情報',
            style: designSystem.typography.displayMedium,
          ),
          SizedBox(height: designSystem.spacing.sm),
          Text(
            '緊急地震速報や地震情報をリアルタイムに受け取るために、'
            '通知と位置情報を許可してください',
            style: designSystem.typography.bodyLarge.copyWith(
              color: designSystem.textColor.secondary,
            ),
          ),
          if (anyDenied) ...[
            SizedBox(height: designSystem.spacing.sm),
            Text(
              '設定アプリからいつでも変更できます',
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.textColor.tertiary,
              ),
            ),
            if (anyDeniedForever) ...[
              SizedBox(height: designSystem.spacing.sm),
              OutlinedButton.icon(
                onPressed: () async => Geolocator.openAppSettings(),
                icon: const Icon(Icons.settings_outlined, size: 18),
                label: const Text('設定アプリを開く'),
              ),
            ],
          ],
          const Spacer(),
          Center(
            child: _OnboardingPermissionsHero(
              color: designSystem.palette.brandPrimary,
              backgroundColor: designSystem.color.surfaceRaised,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
