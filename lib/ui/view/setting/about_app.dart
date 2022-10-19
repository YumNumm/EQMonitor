import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:eqmonitor/ui/view/setting/about_app.viewmodel.dart';
import 'package:eqmonitor/ui/view/widget/setting/about_widget.dart';
import 'package:eqmonitor/ui/view/widget/setting/fcm_token_widget.dart';
import 'package:eqmonitor/ui/view/widget/setting/license_widget.dart';
import 'package:eqmonitor/ui/view/widget/setting/setting_section.dart';
import 'package:eqmonitor/ui/view/widget/setting/thanks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
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
                  onLongPressMoveUpdate: (_) => context.go('/full_screen'),
                  onScaleStart: (_) =>
                      viewModel.onDeveloperModeTilePressed(context),
                  child: Image.asset(
                    isDarkMode ? 'assets/header-dark.png' : 'assets/header.png',
                  ),
                ),
              ),
            ),
            const Divider(),
            const SettingsSection(
              title: 'アプリ情報',
              children: [
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
