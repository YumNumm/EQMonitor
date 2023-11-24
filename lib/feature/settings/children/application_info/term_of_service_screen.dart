import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class TermOfServiceScreen extends HookWidget {
  const TermOfServiceScreen({
    required this.onResult,
    this.showAcceptButton = false,
    super.key,
  });

  final void Function({bool isAccepted})? onResult;
  final bool showAcceptButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('利用規約'),
      ),
      body: const _TermOfServiceScreenBody(),
    );
  }
}

class _TermOfServiceScreenBody extends HookWidget {
  const _TermOfServiceScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final markdownBody = useFuture(
      useMemoized(() => rootBundle.loadString(Assets.docs.termOfService)),
      initialData: '',
    );
    final data = markdownBody.data;
    if (data == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Markdown(
      data: data,
      selectable: true,
      onTapLink: (text, href, title) async {
        final uri = Uri.tryParse(href.toString());
        if (uri == null) {
          return;
        }
        await launchUrl(
          uri,
        );
      },
    );
  }
}
