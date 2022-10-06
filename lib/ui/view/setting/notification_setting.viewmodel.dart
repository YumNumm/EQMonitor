import 'package:eqmonitor/provider/setting/notification_settings.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class NotificationSettingViewModel {
  const NotificationSettingViewModel(this.ref);
  final WidgetRef ref;

  /// 震度の選択ドロップダウンタップ時
  Future<void> onIntensityTap(BuildContext context) async {
    final intensity = await _showIntensitySelectDropdown(context);
    if (intensity != null) {
      ref
          .read(notificationSettingsProvider.notifier)
          .setIntensityThreshold(intensity);
    }
  }

  /// TTSの切り替え
  void onTtsSwitchChanged() =>
      ref.read(notificationSettingsProvider.notifier).toggleUseTts();

  Future<JmaIntensity?> _showIntensitySelectDropdown(
    BuildContext context,
  ) async =>
      showDialog<JmaIntensity>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('予想最大震度のしきい値'),
            children: [
              for (final intensity in JmaIntensity.values)
                if (<JmaIntensity>[
                  JmaIntensity.Error,
                  JmaIntensity.Unknown,
                  JmaIntensity.over
                ].contains(intensity))
                  const SizedBox.shrink()
                else
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop(intensity);
                    },
                    child: Text(
                      (intensity == JmaIntensity.Int0)
                          ? '全て'
                          : intensity.longName,
                    ),
                  ),
            ],
          );
        },
      );
}
