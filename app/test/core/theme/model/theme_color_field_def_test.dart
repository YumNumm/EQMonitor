import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/map_colors.dart';
import 'package:eqmonitor/core/theme/model/status_colors.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final base = AppTheme.eqmonitorDefault().light!;
  const probe = Color(0xFF123456);

  test('全30件のフィールド定義が存在する', () {
    expect(ThemeColorFieldDefs.all.length, 30);
  });

  test('全定義について description が空でない', () {
    for (final def in ThemeColorFieldDefs.all) {
      expect(
        def.description,
        isNotEmpty,
        reason: '${def.label} の description が空です',
      );
    }
  });

  test('各定義について setter(base, probe) 後に getter が probe を返す', () {
    for (final def in ThemeColorFieldDefs.all) {
      final updated = def.setter(base, probe);
      expect(
        def.getter(updated),
        probe,
        reason: '${def.label} の getter/setter が不整合です',
      );
    }
  });

  test('全定義をprobeで書き換えるとtoJsonの全Colorフィールドがprobeになる (ラウンドトリップ)', () {
    var mutated = base;
    for (final def in ThemeColorFieldDefs.all) {
      mutated = def.setter(mutated, probe);
    }
    final json = mutated.toJson();
    // probe(0xFF123456)は不透明なため ColorJsonConverter は
    // '#RRGGBB' 形式(大文字16進)で出力する。
    const expectedHex = '#123456';
    // ThemeColorSet.toJson()は@JsonKey(fieldRename: snake)相当のため
    // snake_case キーで出力される(theme_color_set.g.dart参照)。
    const flatColorKeys = [
      'primary',
      'on_primary',
      'primary_container',
      'on_primary_container',
      'secondary',
      'secondary_container',
      'on_secondary_container',
      'tertiary',
      'tertiary_container',
      'on_tertiary_container',
      'error',
      'error_container',
      'on_error_container',
      'surface',
      'on_surface',
      'on_surface_variant',
      'surface_container_low',
      'surface_container',
      'surface_container_high',
      'surface_container_highest',
      'outline',
      'outline_variant',
      'on_inverse_surface',
    ];
    for (final key in flatColorKeys) {
      expect(json[key], expectedHex, reason: 'key=$key');
    }
    // ThemeColorSet.toJson()はネストしたFreezedオブジェクト(status/map)を
    // 再帰的にMapへ変換しないため、それぞれの.toJson()を呼び出して検証する。
    final status = (json['status'] as StatusColors).toJson();
    for (final key in ['success', 'warning']) {
      expect(status[key], expectedHex, reason: 'status.$key');
    }
    final map = (json['map'] as MapColors).toJson();
    for (final key in [
      'background',
      'world_land',
      'world_line',
      'japan_land',
      'japan_line',
    ]) {
      expect(map[key], expectedHex, reason: 'map.$key');
    }
  });
}
