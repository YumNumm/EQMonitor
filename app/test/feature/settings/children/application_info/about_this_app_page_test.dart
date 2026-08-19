import 'dart:convert';

import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/settings/children/application_info/about_this_app_page.dart';
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    as flutter_localizations;
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('マークダウン本文はテーマのonSurface色を使う', (tester) async {
    final appTheme = AppTheme.eqmonitorDefault();
    for (final brightness in Brightness.values) {
      final colorSet = brightness == Brightness.light
          ? appTheme.light
          : appTheme.dark;
      if (colorSet == null) {
        throw StateError('$brightness theme is missing');
      }

      await tester.pumpWidget(
        DefaultAssetBundle(
          bundle: _MarkdownAssetBundle(),
          child: MaterialApp(
            theme: AppThemeDataBuilder.build(
              colorSet: colorSet,
              brightness: brightness,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              flutter_localizations.GlobalMaterialLocalizations.delegate,
              flutter_localizations.GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ja', 'JP')],
            themeAnimationDuration: Duration.zero,
            home: const AboutThisAppPage(),
          ),
        ),
      );
      await tester.pump();

      final markdown = tester.widget<MarkdownBody>(find.byType(MarkdownBody));
      expect(markdown.styleSheet?.p?.color, colorSet.onSurface);
      expect(markdown.styleSheet?.a?.color, colorSet.primary);
      expect(find.byType(ListView), findsOneWidget);
    }
  });
}

final class _MarkdownAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(Uint8List.fromList(utf8.encode('# 見出し\n本文')));
}
