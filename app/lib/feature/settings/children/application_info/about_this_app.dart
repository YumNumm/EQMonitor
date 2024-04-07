import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutThisAppScreen extends HookWidget {
  const AboutThisAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final markdownFuture =
        useMemoized(() => rootBundle.loadString(Assets.docs.aboutThisApp));
    final markdown = useFuture(markdownFuture);
    return Scaffold(
      appBar: AppBar(
        title: const Text('このアプリについて'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: const Text('利用規約'),
                leading: const Icon(Icons.description),
                onTap: () =>
                    const TermOfServiceRoute($extra: null).push<void>(context),
              ),
              ListTile(
                title: const Text('プライバシーポリシー'),
                leading: const Icon(Icons.info),
                onTap: () =>
                    const PrivacyPolicyRoute($extra: null).push<void>(context),
              ),
              ListTile(
                title: const Text('ライセンス情報'),
                subtitle:
                    Text('MIT License ${DateTime.now().year} Ryotaro Onoue'),
                leading: const Icon(Icons.settings),
                onTap: () => const LicenseRoute().push<void>(context),
              ),
              const Divider(),
              BorderedContainer(
                elevation: 1,
                child: MarkdownBody(
                  softLineBreak: true,
                  data: markdown.data ?? '',
                  onTapLink: (text, href, title) async {
                    final uri = Uri.tryParse(href ?? '');
                    if (uri != null && await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
