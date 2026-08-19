import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutThisAppPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final assetBundle = DefaultAssetBundle.of(context);
    final markdownFuture = useMemoized(
      () async => assetBundle.loadString(Assets.docs.aboutThisApp),
      [assetBundle],
    );
    final markdown = useFuture(markdownFuture);
    final markdownStyleSheet = MarkdownStyleSheet(
      a: designSystem.typography.bodyMedium.copyWith(
        color: designSystem.colorTheme.primary,
        decoration: TextDecoration.underline,
      ),
      p: designSystem.typography.bodyMedium.copyWith(
        color: designSystem.colorTheme.onSurface,
      ),
      code: designSystem.typography.monoSmall.copyWith(
        color: designSystem.colorTheme.onSurface,
        backgroundColor: designSystem.colorTheme.surfaceContainerHigh,
      ),
      h1: designSystem.typography.headlineSmall,
      h2: designSystem.typography.titleLarge,
      h3: designSystem.typography.titleMedium,
      h4: designSystem.typography.titleSmall,
      h5: designSystem.typography.bodyLarge,
      h6: designSystem.typography.bodyMedium,
      blockquote: designSystem.typography.bodyMedium.copyWith(
        color: designSystem.colorTheme.onSurfaceVariant,
      ),
      listBullet: designSystem.typography.bodyMedium.copyWith(
        color: designSystem.colorTheme.onSurface,
      ),
      blockSpacing: designSystem.spacing.sm,
      listIndent: designSystem.spacing.xxl,
      codeblockPadding: EdgeInsets.all(designSystem.spacing.sm),
      codeblockDecoration: BoxDecoration(
        color: designSystem.colorTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(designSystem.shape.sm),
      ),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: designSystem.colorTheme.outlineVariant),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('このアプリについて')),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text('利用規約', style: designSystem.typography.bodyLarge),
              leading: Icon(
                Icons.description,
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
              onTap: () async => const TermOfServiceRoute().push<void>(context),
            ),
            ListTile(
              title: Text(
                'プライバシーポリシー',
                style: designSystem.typography.bodyLarge,
              ),
              leading: Icon(
                Icons.info,
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
              onTap: () async => const PrivacyPolicyRoute().push<void>(context),
            ),
            ListTile(
              title: Text('ライセンス情報', style: designSystem.typography.bodyLarge),
              subtitle: Text(
                'MIT License ${DateTime.now().year} Ryotaro Onoue',
                style: designSystem.typography.bodyMedium,
              ),
              leading: Icon(
                Icons.settings,
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
              onTap: () async => const LicenseRoute().push<void>(context),
            ),
            Divider(color: designSystem.colorTheme.outlineVariant),
            BorderedContainer(
              elevation: 1,
              padding: EdgeInsets.all(designSystem.spacing.lg),
              margin: EdgeInsets.symmetric(
                vertical: designSystem.spacing.xs,
                horizontal: designSystem.spacing.sm,
              ),
              borderRadius: BorderRadius.circular(designSystem.shape.card),
              child: MarkdownBody(
                softLineBreak: true,
                data: markdown.data ?? '',
                styleSheet: markdownStyleSheet,
                onTapLink: (text, href, title) async {
                  final uri = Uri.tryParse(href ?? '');
                  if (uri != null && await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              ),
            ),
            const _DeviceIdTile(),
          ],
        ),
      ),
    );
  }
}

class _DeviceIdTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final deviceId = switch (ref.watch(deviceIdProvider)) {
      AsyncData(:final value) => value,
      AsyncError() => '取得に失敗しました',
      _ => '取得中...',
    };

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: designSystem.spacing.sm,
        horizontal: designSystem.spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'デバイスID',
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: designSystem.spacing.xs),
          SelectableText(
            deviceId,
            style: designSystem.typography.monoSmall.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
