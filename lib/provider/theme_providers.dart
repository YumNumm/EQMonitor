import '../model/setting/theme_model.dart';
import 'setting/theme_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeModel>(
  (ref) => ThemeProvider(),
);
