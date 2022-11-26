import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/setting/theme_model.dart';
import 'setting/theme_controller.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeModel>(
  ThemeProvider.new,
);
