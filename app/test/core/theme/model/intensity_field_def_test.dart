import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_field_def.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final base = AppTheme.eqmonitorDefault().light!;
  const probeEntry = IntensityColorEntry(
    background: Color(0xFF123456),
    foreground: IntensityTextColor.manual(color: Color(0xFF654321)),
  );

  test('intensity 11件 + estimatedIntensity 6件 = 17件の定義が存在する', () {
    expect(IntensityFieldDefs.all.length, 17);
    expect(
      IntensityFieldDefs.all
          .where((e) => e.group == IntensityFieldGroup.intensity)
          .length,
      11,
    );
    expect(
      IntensityFieldDefs.all
          .where((e) => e.group == IntensityFieldGroup.estimatedIntensity)
          .length,
      6,
    );
  });

  test(
    '各定義について entrySetter(base, probeEntry) 後に entryGetter が probeEntry を返す',
    () {
      for (final def in IntensityFieldDefs.all) {
        final updated = def.entrySetter(base, probeEntry);
        expect(
          def.entryGetter(updated),
          probeEntry,
          reason: '${def.label} の entryGetter/entrySetter が不整合です',
        );
      }
    },
  );

  test('IntensityFieldGroup の全値について description が空でない', () {
    for (final group in IntensityFieldGroup.values) {
      expect(
        group.description,
        isNotEmpty,
        reason: '$group の description が空です',
      );
    }
  });
}
