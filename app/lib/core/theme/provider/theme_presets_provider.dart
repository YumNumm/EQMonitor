import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_presets_provider.g.dart';

@riverpod
List<AppTheme> themePresets(Ref ref) => [
  AppTheme.eqmonitorDefault(),
  AppTheme.jmaStandard(),
];
