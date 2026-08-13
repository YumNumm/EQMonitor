import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';

/// スコープに対する検索パラメータが取れない（未設定 / 未解決）ときに
/// シート上に表示する案内ブロック。
///
/// 文言と再試行導線をスコープごとに切り替える。
/// 位置情報がらみのケースでは権限状態に応じてさらに細かく分岐する。
class HomeScopeUnavailableBody extends StatelessWidget {
  const HomeScopeUnavailableBody({
    required this.scope,
    required this.onRetry,
    this.onConfigureRegion,
    super.key,
  });

  final HomeEarthquakeHistoryScope scope;
  final VoidCallback onRetry;
  final VoidCallback? onConfigureRegion;

  @override
  Widget build(BuildContext context) {
    return switch (scope) {
      HomeEarthquakeHistoryScope.nationwide => const SizedBox.shrink(),
      HomeEarthquakeHistoryScope.currentLocation => _CurrentLocationUnavailable(
        onRetry: onRetry,
      ),
      HomeEarthquakeHistoryScope.custom => _CustomUnavailable(
        onConfigureRegion: onConfigureRegion,
      ),
    };
  }
}

class _UnavailableContainer extends StatelessWidget {
  const _UnavailableContainer({
    required this.icon,
    required this.message,
    this.actions = const [],
  });

  final IconData icon;
  final String message;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.lg,
      ),
      child: Container(
        padding: EdgeInsets.all(spacing.lg),
        decoration: BoxDecoration(
          color: colorTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(shape.lg),
          border: Border.all(color: colorTheme.outlineVariant),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: designSystem.colorTheme.onSurfaceVariant),
            SizedBox(height: spacing.sm),
            Text(
              message,
              style: typography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actions.isNotEmpty) ...[
              SizedBox(height: spacing.md),
              Wrap(
                spacing: spacing.sm,
                runSpacing: spacing.sm,
                alignment: WrapAlignment.center,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CurrentLocationUnavailable extends HookWidget {
  const _CurrentLocationUnavailable({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final permission = useState<LocationPermission?>(null);

    Future<void> refreshPermission() async {
      final p = await Geolocator.checkPermission();
      permission.value = p;
    }

    useEffect(() {
      unawaited(Future.microtask(refreshPermission));
      return null;
    }, const []);

    // 権限取得中はスケルトンを避けて軽量プレースホルダ
    if (permission.value == null) {
      return const _UnavailableContainer(
        icon: Icons.location_searching_outlined,
        message: '現在地を取得しています…',
      );
    }

    // 権限がない / 永続拒否 / それでも取れない、それぞれに合わせて文言と
    // アクションを切り替える。
    return switch (permission.value!) {
      LocationPermission.denied => _UnavailableContainer(
        icon: Icons.location_off_outlined,
        message: '位置情報の利用が許可されていません。許可すると現在地周辺の地震を表示できます。',
        actions: [
          FilledButton.tonal(
            onPressed: () async {
              await Geolocator.requestPermission();
              await refreshPermission();
              onRetry();
            },
            child: const Text('位置情報を許可する'),
          ),
        ],
      ),
      LocationPermission.deniedForever => _UnavailableContainer(
        icon: Icons.location_disabled_outlined,
        message: '位置情報の利用が拒否されています。アプリの設定から許可してください。',
        actions: [
          FilledButton.tonal(
            onPressed: () async {
              await Geolocator.openAppSettings();
              await refreshPermission();
              onRetry();
            },
            child: const Text('設定を開く'),
          ),
        ],
      ),
      _ => _UnavailableContainer(
        // 権限はあるが位置・市区町村の解決に失敗しているケース。
        icon: Icons.gps_not_fixed_outlined,
        message: '現在地から地震情報を取得できませんでした。電波状況などをご確認のうえ再試行してください。',
        actions: [
          OutlinedButton.icon(
            onPressed: () {
              onRetry();
              unawaited(Future.microtask(refreshPermission));
            },
            icon: const Icon(Icons.refresh),
            label: const Text('再試行'),
          ),
        ],
      ),
    };
  }
}

class _CustomUnavailable extends StatelessWidget {
  const _CustomUnavailable({this.onConfigureRegion});

  final VoidCallback? onConfigureRegion;

  @override
  Widget build(BuildContext context) {
    return _UnavailableContainer(
      icon: Icons.tune_outlined,
      message: '指定地域が未設定です。表示したい都道府県・市区町村を選んでください。',
      actions: [
        if (onConfigureRegion != null)
          FilledButton.tonal(
            onPressed: onConfigureRegion,
            child: const Text('地域を設定する'),
          ),
      ],
    );
  }
}
