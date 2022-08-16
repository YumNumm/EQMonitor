import 'package:eqmonitor/model/setting/theme_model.dart';
import 'package:eqmonitor/provider/setting/theme_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeModel>(
  (ref) => ThemeProvider(),
);
