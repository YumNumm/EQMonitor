import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'introduction/files_download.dart';
import 'introduction/welcome.dart';
import 'setting/term_of_service.dart';

final introductionController =
    Provider<PageController>((ref) => PageController());

class IntroductionPage extends HookConsumerWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      controller: ref.watch(introductionController),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        WelcomeWidget(),
        TermOfServicePage(showAcceptButton: true),
        FilesDownloadWidget(),
      ],
    );
  }
}
