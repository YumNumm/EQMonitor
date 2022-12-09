import '../../route.dart';
import 'component/fcm_token_widget.dart';
import 'component/license_widget.dart';
import 'component/log_view_widget.dart';
import 'component/setting_section.dart';
import 'component/thanks_widget.dart';
import 'component/update_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/theme_providers.dart';
import 'about_app.viewmodel.dart';
import 'component/about_widget.dart';

class AboutAppPage extends HookConsumerWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider.notifier).isDarkMode;
    final logoTapCount = useState<int>(0);
    final viewModel = AboutAppViewModel(ref);

    return Scaffold(
      appBar: AppBar(title: const Text('本アプリについて')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: (constraints.maxWidth >
                            MediaQuery.of(context).size.height)
                        ? MediaQuery.of(context).size.height
                        : constraints.maxWidth * 0.8,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          logoTapCount.value++;
                          if (logoTapCount.value == 10) {
                            logoTapCount.value = 0;
                            viewModel.startKmoniTest(context);
                          }
                        },
                        onLongPressMoveUpdate: (_) =>
                            FullScreenRoute().push(context),
                        onScaleStart: (_) =>
                            viewModel.onDeveloperModeTilePressed(context),
                        child: RepaintBoundary(
                          child: Image.asset(
                            isDarkMode
                                ? 'assets/header-dark.png'
                                : 'assets/header.png',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const LogViewButtonWidget(),
            const Divider(),
            const SettingsSection(
              title: 'アプリ情報',
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: UpdateHistoryButtonWidget(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: AboutWidget(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LicenseWidget(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: FcmTokenWidget(),
                ),
              ],
            ),
            const SettingsSection(
              title: 'その他',
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ThanksWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
