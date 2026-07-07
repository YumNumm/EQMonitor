import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/dialog/notification_permission_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum NotificationPresetSelectorStyle { onboarding, settings }

class NotificationPresetSelector extends HookConsumerWidget {
  const NotificationPresetSelector({
    required this.selectedPreset,
    required this.onChanged,
    required this.style,
    this.onCustomSettingsTap,
    super.key,
  });

  final NotificationPreset selectedPreset;
  final ValueChanged<NotificationPreset> onChanged;
  final NotificationPresetSelectorStyle style;
  final VoidCallback? onCustomSettingsTap;

  static const _presetOrder = <NotificationPreset>[
    NotificationPreset.recommended,
    NotificationPreset.all,
    NotificationPreset.custom,
    NotificationPreset.none,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionAsync = ref.watch(osNotificationPermissionProvider);
    final permission = switch (permissionAsync) {
      AsyncData(:final value) => value,
      _ => null,
    };
    final isOsGranted = permission?.isOsNotificationGranted ?? false;

    useEffect(
      () {
        if (permission != null &&
            !permission.isOsNotificationGranted &&
            selectedPreset != NotificationPreset.none) {
          onChanged(NotificationPreset.none);
        }
        return null;
      },
      [permission, selectedPreset],
    );

    void handlePresetTap(NotificationPreset preset) {
      if (!isOsGranted && preset != NotificationPreset.none) {
        showOsNotificationPermissionDialog(context, ref);
        return;
      }

      if (style == NotificationPresetSelectorStyle.settings &&
          preset == NotificationPreset.custom &&
          selectedPreset == NotificationPreset.custom) {
        onCustomSettingsTap?.call();
        return;
      }

      onChanged(preset);
    }

    bool isPresetEnabled(NotificationPreset preset) {
      return isOsGranted || preset == NotificationPreset.none;
    }

    bool shouldShowCriticalWarning(NotificationPreset preset) {
      if (permission == null) {
        return false;
      }
      return selectedPreset == preset &&
          (preset == NotificationPreset.recommended ||
              preset == NotificationPreset.all) &&
          permission.isCriticalAlertSupported &&
          !permission.isCriticalAlertGranted;
    }

    return switch (style) {
      NotificationPresetSelectorStyle.onboarding => _OnboardingPresetList(
        presets: _presetOrder,
        selectedPreset: selectedPreset,
        isPresetEnabled: isPresetEnabled,
        shouldShowCriticalWarning: shouldShowCriticalWarning,
        onPresetTap: handlePresetTap,
        onCriticalWarningTap: () =>
            showCriticalAlertPermissionDialog(context, ref),
      ),
      NotificationPresetSelectorStyle.settings => _SettingsPresetGroup(
        presets: _presetOrder,
        selectedPreset: selectedPreset,
        isPresetEnabled: isPresetEnabled,
        shouldShowCriticalWarning: shouldShowCriticalWarning,
        onPresetTap: handlePresetTap,
        onCustomSettingsTap: onCustomSettingsTap,
        onCriticalWarningTap: () =>
            showCriticalAlertPermissionDialog(context, ref),
      ),
    };
  }
}

class _OnboardingPresetList extends StatelessWidget {
  const _OnboardingPresetList({
    required this.presets,
    required this.selectedPreset,
    required this.isPresetEnabled,
    required this.shouldShowCriticalWarning,
    required this.onPresetTap,
    required this.onCriticalWarningTap,
  });

  final List<NotificationPreset> presets;
  final NotificationPreset selectedPreset;
  final bool Function(NotificationPreset preset) isPresetEnabled;
  final bool Function(NotificationPreset preset) shouldShowCriticalWarning;
  final ValueChanged<NotificationPreset> onPresetTap;
  final VoidCallback onCriticalWarningTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < presets.length; index++) ...[
          if (index > 0) SizedBox(height: designSystem.spacing.md),
          _OnboardingPresetCard(
            preset: presets[index],
            isSelected: selectedPreset == presets[index],
            isEnabled: isPresetEnabled(presets[index]),
            showCriticalWarning: shouldShowCriticalWarning(presets[index]),
            onTap: () => onPresetTap(presets[index]),
            onCriticalWarningTap: onCriticalWarningTap,
          ),
        ],
      ],
    );
  }
}

class _OnboardingPresetCard extends StatelessWidget {
  const _OnboardingPresetCard({
    required this.preset,
    required this.isSelected,
    required this.isEnabled,
    required this.showCriticalWarning,
    required this.onTap,
    required this.onCriticalWarningTap,
  });

  final NotificationPreset preset;
  final bool isSelected;
  final bool isEnabled;
  final bool showCriticalWarning;
  final VoidCallback onTap;
  final VoidCallback onCriticalWarningTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;

    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(designSystem.spacing.md),
          decoration: BoxDecoration(
            color: colorTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(designSystem.shape.card),
            border: Border.all(
              color: isSelected
                  ? colorTheme.primary
                  : colorTheme.outlineVariant,
              width: isSelected ? 2 : 0,
              strokeAlign: BorderSide.strokeAlignOutside,
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
                        ? colorTheme.primary
                        : colorTheme.outline,
                    size: 20,
                  ),
                  SizedBox(width: designSystem.spacing.sm),
                  Expanded(
                    child: Text(
                      _presetTitle(preset),
                      style: designSystem.typography.titleMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: designSystem.spacing.sm),
              Padding(
                padding: EdgeInsets.only(
                  left: designSystem.spacing.lg + designSystem.spacing.xs,
                ),
                child: _OnboardingPresetDescription(preset: preset),
              ),
              if (showCriticalWarning) ...[
                SizedBox(height: designSystem.spacing.sm),
                Padding(
                  padding: EdgeInsets.only(
                    left: designSystem.spacing.lg + designSystem.spacing.xs,
                  ),
                  child: _CriticalAlertWarningLink(
                    onTap: onCriticalWarningTap,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPresetDescription extends StatelessWidget {
  const _OnboardingPresetDescription({required this.preset});

  final NotificationPreset preset;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return switch (preset) {
      NotificationPreset.recommended => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PresetBulletItem(
            text: '現在地の緊急地震速報(警報)',
            designSystem: designSystem,
          ),
          _PresetBulletItem(
            text: '現在地で予想震度4以上の緊急地震速報(予報)',
            designSystem: designSystem,
          ),
          _PresetBulletItem(
            text: '現在地で震度1以上を観測した地震情報',
            designSystem: designSystem,
          ),
        ],
      ),
      NotificationPreset.all => _PresetBulletItem(
        text: '推奨設定に加え、全国の緊急地震速報・地震情報も通知します',
        designSystem: designSystem,
      ),
      NotificationPreset.custom => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PresetBulletItem(
            text: '通知する地域や震度を細かく設定できます',
            designSystem: designSystem,
          ),
          _PresetBulletItem(
            text: 'Proではさらに通知音や割り込みレベルを設定できます',
            designSystem: designSystem,
          ),
        ],
      ),
      NotificationPreset.none => _PresetBulletItem(
        text: '通知を受け取りません。後から設定で変更できます',
        designSystem: designSystem,
      ),
    };
  }
}

class _PresetBulletItem extends StatelessWidget {
  const _PresetBulletItem({
    required this.text,
    required this.designSystem,
  });

  final String text;
  final DesignSystemThemeExtension designSystem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: designSystem.spacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '・',
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsPresetGroup extends StatelessWidget {
  const _SettingsPresetGroup({
    required this.presets,
    required this.selectedPreset,
    required this.isPresetEnabled,
    required this.shouldShowCriticalWarning,
    required this.onPresetTap,
    required this.onCustomSettingsTap,
    required this.onCriticalWarningTap,
  });

  final List<NotificationPreset> presets;
  final NotificationPreset selectedPreset;
  final bool Function(NotificationPreset preset) isPresetEnabled;
  final bool Function(NotificationPreset preset) shouldShowCriticalWarning;
  final ValueChanged<NotificationPreset> onPresetTap;
  final VoidCallback? onCustomSettingsTap;
  final VoidCallback onCriticalWarningTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.md,
      ),
      color: colorTheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < presets.length; index++) ...[
            if (index > 0) const Divider(height: 1),
            _SettingsPresetTile(
              preset: presets[index],
              isSelected: selectedPreset == presets[index],
              isEnabled: isPresetEnabled(presets[index]),
              showCriticalWarning: shouldShowCriticalWarning(presets[index]),
              onTap: () => onPresetTap(presets[index]),
              onCustomSettingsTap: onCustomSettingsTap,
              onCriticalWarningTap: onCriticalWarningTap,
            ),
          ],
        ],
      ),
    );
  }
}

class _SettingsPresetTile extends StatelessWidget {
  const _SettingsPresetTile({
    required this.preset,
    required this.isSelected,
    required this.isEnabled,
    required this.showCriticalWarning,
    required this.onTap,
    required this.onCustomSettingsTap,
    required this.onCriticalWarningTap,
  });

  final NotificationPreset preset;
  final bool isSelected;
  final bool isEnabled;
  final bool showCriticalWarning;
  final VoidCallback onTap;
  final VoidCallback? onCustomSettingsTap;
  final VoidCallback onCriticalWarningTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final colorTheme = designSystem.colorTheme;
    final titleColor = isEnabled
        ? colorTheme.onSurface
        : Theme.of(context).disabledColor;
    final subtitleColor = isEnabled
        ? colorTheme.onSurfaceVariant
        : Theme.of(context).disabledColor;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.lg,
          vertical: spacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PresetSelectionMark(isSelected: isSelected && isEnabled),
            SizedBox(width: spacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _presetTitle(preset),
                    style: designSystem.typography.titleMedium.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: spacing.xs),
                  Text(
                    _settingsSubtitle(preset),
                    style: designSystem.typography.bodySmall.copyWith(
                      color: subtitleColor,
                    ),
                  ),
                  if (showCriticalWarning) ...[
                    SizedBox(height: spacing.xs),
                    _CriticalAlertWarningLink(onTap: onCriticalWarningTap),
                  ],
                ],
              ),
            ),
            if (preset == NotificationPreset.custom &&
                onCustomSettingsTap != null) ...[
              SizedBox(width: spacing.sm),
              _CustomPresetTrailing(
                enabled: isSelected && isEnabled,
                onTap: onCustomSettingsTap!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PresetSelectionMark extends StatelessWidget {
  const _PresetSelectionMark({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? colorTheme.primary : colorTheme.outline,
          width: isSelected ? 6 : 3,
        ),
      ),
    );
  }
}

class _CustomPresetTrailing extends StatelessWidget {
  const _CustomPresetTrailing({
    required this.enabled,
    required this.onTap,
  });

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.chevron_right,
          color: enabled ? null : Theme.of(context).disabledColor,
        ),
        SizedBox(
          height: 40,
          child: VerticalDivider(
            color: designSystem.colorTheme.outlineVariant,
            thickness: 1,
          ),
        ),
        IconButton(
          tooltip: 'カスタム設定',
          onPressed: enabled ? onTap : null,
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }
}

class _CriticalAlertWarningLink extends HookWidget {
  const _CriticalAlertWarningLink({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final recognizer = useMemoized(TapGestureRecognizer.new);

    useEffect(
      () {
        recognizer.onTap = onTap;
        return recognizer.dispose;
      },
      [recognizer, onTap],
    );

    return Text.rich(
      TextSpan(
        text: '重大な通知が許可されていません',
        style: designSystem.typography.bodySmall.copyWith(
          color: designSystem.colorTheme.primary,
          decoration: TextDecoration.underline,
        ),
        recognizer: recognizer,
      ),
    );
  }
}

String _presetTitle(NotificationPreset preset) {
  return switch (preset) {
    NotificationPreset.recommended => '推奨設定',
    NotificationPreset.all => 'すべて',
    NotificationPreset.custom => 'カスタム',
    NotificationPreset.none => '通知しない',
  };
}

String _settingsSubtitle(NotificationPreset preset) {
  return switch (preset) {
    NotificationPreset.recommended =>
      '現在地の震度に応じて、EEWと地震情報を自動で通知します',
    NotificationPreset.all =>
      '推奨設定に加え、全国の緊急地震速報・地震情報も通知します',
    NotificationPreset.custom => '通知の種類ごとに条件を細かく設定します',
    NotificationPreset.none => '通知を受け取りません。後から設定で変更できます',
  };
}
