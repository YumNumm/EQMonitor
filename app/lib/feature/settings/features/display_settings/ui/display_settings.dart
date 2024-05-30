import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/theme/theme_provider.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DisplaySettingsScreen extends StatelessWidget {
  const DisplaySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('表示設定'),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsSectionHeader(
              text: '配色設定',
            ),
            const _ThemeSelector(),
            const Divider(),
            ListTile(
              title: const Text('震度配色設定'),
              leading: const Icon(Icons.color_lens),
              onTap: () => const ColorSchemeConfigRoute().push<void>(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSelector extends ConsumerWidget {
  const _ThemeSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(themeModeNotifierProvider);

    final brightness = MediaQuery.platformBrightnessOf(context);

    Widget buildThemeChoice(ThemeMode mode) {
      final modeBrightness =
          mode == ThemeMode.light ? Brightness.light : Brightness.dark;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            ref.read(themeModeNotifierProvider.notifier).update(mode);
          },
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: switch (mode) {
                    ThemeMode.light => Assets.images.theme.light.image(
                        fit: BoxFit.contain,
                      ),
                    ThemeMode.dark => Assets.images.theme.dark.image(),
                    _ => throw UnimplementedError(),
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                switch (mode) {
                  ThemeMode.light => 'ライト',
                  ThemeMode.dark => 'ダーク',
                  _ => throw UnimplementedError(),
                },
              ),
              const SizedBox(
                height: 4,
              ),
              Radio.adaptive(
                value: state == ThemeMode.system
                    ? brightness == modeBrightness
                        ? ThemeMode.system
                        : null
                    : mode,
                groupValue: state,
                onChanged: (value) {
                  ref.read(themeModeNotifierProvider.notifier).update(mode);
                },
              ),
            ],
          ),
        ),
      );
    }

    final size = MediaQuery.of(context).size;
    final width = size.width > 600.0 ? 300.0 : null;

    final choice = Center(
      child: SizedBox(
        width: width,
        child: Row(
          children: [
            buildThemeChoice(ThemeMode.light),
            const SizedBox(width: 4),
            buildThemeChoice(ThemeMode.dark),
          ],
        ),
      ),
    );

    return BorderedContainer(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: state == ThemeMode.system ? 0.5 : 1.0,
            child: IgnorePointer(
              ignoring: state == ThemeMode.system,
              child: choice,
            ),
          ),
          SwitchListTile.adaptive(
            visualDensity: VisualDensity.compact,
            title: const Text('システム設定に従う'),
            value: state == ThemeMode.system,
            onChanged: (value) {
              ref.read(themeModeNotifierProvider.notifier).update(
                    value
                        ? ThemeMode.system
                        : PlatformDispatcher.instance.platformBrightness ==
                                Brightness.light
                            ? ThemeMode.light
                            : ThemeMode.dark,
                  );
            },
          ),
        ],
      ),
    );
  }
}
