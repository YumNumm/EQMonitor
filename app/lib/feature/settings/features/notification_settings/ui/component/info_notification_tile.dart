import 'dart:async';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/info_link.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showInfoBottomSheet(
  BuildContext context, {
  required String title,
  required List<InfoLink> links,
}) {
  unawaited(showModalBottomSheet<void>(
    context: context,
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final link in links)
              ListTile(
                title: Text(
                  link.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () => launchUrl(
                  Uri.parse(link.url),
                  mode: LaunchMode.externalApplication,
                ),
              ),
          ],
        ),
      ),
    ),
  ));
}

class InfoNotificationTile extends StatelessWidget {
  const InfoNotificationTile({
    required this.title,
    required this.subtitleText,
    required this.value,
    required this.onChanged,
    required this.bottomSheetTitle,
    required this.bottomSheetLinks,
    super.key,
  });

  final String title;
  final String subtitleText;
  final bool value;
  final Future<void> Function({required bool value}) onChanged;
  final String bottomSheetTitle;
  final List<InfoLink> bottomSheetLinks;

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.designSystem.colorTheme.primary;

    return ListTile(
      title: Text(title),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: subtitleText),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => showInfoBottomSheet(
                  context,
                  title: bottomSheetTitle,
                  links: bottomSheetLinks,
                ),
                child: Text(
                  '詳しい情報',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: primaryColor,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      trailing: AppSwitch(
        value: value,
        onChanged: (v) async => onChanged(value: v),
      ),
      onTap: () async => onChanged(value: !value),
    );
  }
}

class ComingSoonBadge extends StatelessWidget {
  const ComingSoonBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorTheme.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          '準備中',
          style: TextStyle(color: colorTheme.onPrimaryContainer),
        ),
      ),
    );
  }
}
