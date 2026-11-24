import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_notice.dart';
import 'package:material_ui/material_ui.dart';

/// 揺れ検知の通知の詳しい説明をボトムシートで表示する。
class const ShakeDetectionNotificationDetailSheetAction() {
  Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) => const _ShakeDetectionNotificationDetailSheet(),
  );
}

class const _ShakeDetectionNotificationDetailSheet() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final textTheme = Theme.of(context).textTheme;
    final bodyStyle = textTheme.bodyMedium?.copyWith(
      color: colorTheme.onSurfaceVariant,
    );
    final sectionStyle = textTheme.titleSmall?.copyWith(
      color: colorTheme.secondary,
    );

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        padding: EdgeInsets.fromLTRB(
          spacing.xxl,
          0,
          spacing.xxl,
          spacing.xxl,
        ),
        children: [
          Text('揺れ検知の通知について', style: textTheme.headlineSmall),
          SizedBox(height: spacing.md),
          Text(
            '強震モニタの観測点で揺れを検知した時に、プッシュ通知でお知らせする機能です。'
            '緊急地震速報や地震情報の発表を待たずに、揺れが観測されたことを知ることができます。',
            style: bodyStyle,
          ),
          SizedBox(height: spacing.xxl),
          Text('使い方', style: sectionStyle),
          SizedBox(height: spacing.sm),
          Text(
            '通知設定で、通知を受け取る地域ごとに有効にできます。'
            '通知する最小の揺れの強さも、地域ごとに選べます。',
            style: bodyStyle,
          ),
          SizedBox(height: spacing.xxl),
          Text('ご利用にあたって', style: sectionStyle),
          for (final notice in ShakeDetectionNotice.all) ...[
            SizedBox(height: spacing.md),
            Text(notice.title, style: textTheme.titleSmall),
            SizedBox(height: spacing.xs),
            Text(notice.body, style: bodyStyle),
          ],
        ],
      ),
    );
  }
}
