import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_code_table_types/jma_code_table.pb.dart';

Widget buildPreview(BuildContext context, Widget child) {
  const brandBlue = Color(0xFF1E88E5);
  final lightColorScheme = ColorScheme.fromSeed(
    seedColor: brandBlue,
  );
  final darkColorScheme = ColorScheme.fromSeed(
    seedColor: brandBlue,
    brightness: Brightness.dark,
  );
  return ProviderScope(
    overrides: [
      // ignore: scoped_providers_should_specify_dependencies
      jmaCodeTableProvider.overrideWithValue(
        JmaCodeTable(
          areaEpicenter: AreaEpicenter(
            items: [
              AreaEpicenter_AreaEpicenterItem(
                code: '100',
                name: '石狩地方北部',
              ),
            ],
          ),
          areaEpicenterDetail: AreaEpicenterDetail(
            items: [
              AreaEpicenterDetail_AreaEpicenterDetailItem(
                code: '1001',
                name: '米国、アラスカ州中央部',
              ),
            ],
          ),
        ),
      ),
      // ignore: scoped_providers_should_specify_dependencies
      intensityColorProvider.overrideWith(
        _FakeIntensityColor.new,
      ),
    ],
    child: MaterialApp(
      home: child,
      theme: buildTheme(
        colorScheme: lightColorScheme,
      ),
      darkTheme: buildTheme(
        colorScheme: darkColorScheme,
      ),
    ),
  );
}

class _FakeIntensityColor extends IntensityColor {
  @override
  IntensityColorModel build() => IntensityColorModel.eqmonitor();
}
