import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/setting/jma_intensity_color_model.dart';
import '../../ui/theme/jma_intensity.dart';
import '../init/shared_preferences.dart';

final jmaIntensityColorProvider =
    StateNotifierProvider<JmaIntensityColorProvider, JmaIntensityColorModel>(
  JmaIntensityColorProvider.new,
);

class JmaIntensityColorProvider extends StateNotifier<JmaIntensityColorModel> {
  JmaIntensityColorProvider(this.ref)
      : super(
          loadFromPrefs(
            ref.read(sharedPreferencesProvder),
          ),
        );

  final Ref ref;

  void load() {
    final prefs = ref.read(sharedPreferencesProvder);
    final model = loadFromPrefs(prefs);
    state = state.copyWith(
      unknown: model.unknown,
      int0: model.int0,
      int1: model.int1,
      int2: model.int2,
      int3: model.int3,
      int4: model.int4,
      int5Lower: model.int5Lower,
      int5Upper: model.int5Upper,
      int6Lower: model.int6Lower,
      int6Upper: model.int6Upper,
      int7: model.int7,
      over: model.over,
      error: model.error,
    );
  }

  static JmaIntensityColorModel loadFromPrefs(
    SharedPreferences prefs,
  ) {
    final unknown = prefs.getInt(JmaIntensity.Unknown.toString());
    final int0 = prefs.getInt(JmaIntensity.Int0.toString());
    final int1 = prefs.getInt(JmaIntensity.Int1.toString());
    final int2 = prefs.getInt(JmaIntensity.Int2.toString());
    final int3 = prefs.getInt(JmaIntensity.Int3.toString());
    final int4 = prefs.getInt(JmaIntensity.Int4.toString());
    final int5Lower = prefs.getInt(JmaIntensity.Int5Lower.toString());
    final int5Upper = prefs.getInt(JmaIntensity.Int5Upper.toString());
    final int6Lower = prefs.getInt(JmaIntensity.Int6Lower.toString());
    final int6Upper = prefs.getInt(JmaIntensity.Int6Upper.toString());
    final int7 = prefs.getInt(JmaIntensity.Int7.toString());
    final over = prefs.getInt(JmaIntensity.over.toString());
    final error = prefs.getInt(JmaIntensity.Error.toString());

    return JmaIntensityColorModel(
      unknown: (unknown == null) ? JmaIntensity.Unknown.color : Color(unknown),
      int0: (int0 == null) ? JmaIntensity.Int0.color : Color(int0),
      int1: (int1 == null) ? JmaIntensity.Int1.color : Color(int1),
      int2: (int2 == null) ? JmaIntensity.Int2.color : Color(int2),
      int3: (int3 == null) ? JmaIntensity.Int3.color : Color(int3),
      int4: (int4 == null) ? JmaIntensity.Int4.color : Color(int4),
      int5Lower:
          (int5Lower == null) ? JmaIntensity.Int5Lower.color : Color(int5Lower),
      int5Upper:
          (int5Upper == null) ? JmaIntensity.Int5Upper.color : Color(int5Upper),
      int6Lower:
          (int6Lower == null) ? JmaIntensity.Int6Lower.color : Color(int6Lower),
      int6Upper:
          (int6Upper == null) ? JmaIntensity.Int6Upper.color : Color(int6Upper),
      int7: (int7 == null) ? JmaIntensity.Int7.color : Color(int7),
      over: (over == null) ? JmaIntensity.over.color : Color(over),
      error: (error == null) ? JmaIntensity.Error.color : Color(error),
    );
  }

  Future<void> saveAll() async {
    final prefs = ref.read(sharedPreferencesProvder);

    await prefs.setInt(JmaIntensity.Unknown.toString(), state.unknown.value);
    await prefs.setInt(JmaIntensity.Int0.toString(), state.int0.value);
    await prefs.setInt(JmaIntensity.Int1.toString(), state.int1.value);
    await prefs.setInt(JmaIntensity.Int2.toString(), state.int2.value);
    await prefs.setInt(JmaIntensity.Int3.toString(), state.int3.value);
    await prefs.setInt(JmaIntensity.Int4.toString(), state.int4.value);
    await prefs.setInt(
      JmaIntensity.Int5Lower.toString(),
      state.int5Lower.value,
    );
    await prefs.setInt(
      JmaIntensity.Int5Upper.toString(),
      state.int5Upper.value,
    );
    await prefs.setInt(
      JmaIntensity.Int6Lower.toString(),
      state.int6Lower.value,
    );
    await prefs.setInt(
      JmaIntensity.Int6Upper.toString(),
      state.int6Upper.value,
    );
    await prefs.setInt(JmaIntensity.Int7.toString(), state.int7.value);
    await prefs.setInt(JmaIntensity.over.toString(), state.over.value);
    await prefs.setInt(JmaIntensity.Error.toString(), state.error.value);
  }

  void change(JmaIntensity intensity, Color color) {
    state = state.copyWith(
      unknown: (intensity == JmaIntensity.Unknown) ? color : state.unknown,
      int0: (intensity == JmaIntensity.Int0) ? color : state.int0,
      int1: (intensity == JmaIntensity.Int1) ? color : state.int1,
      int2: (intensity == JmaIntensity.Int2) ? color : state.int2,
      int3: (intensity == JmaIntensity.Int3) ? color : state.int3,
      int4: (intensity == JmaIntensity.Int4) ? color : state.int4,
      int5Lower:
          (intensity == JmaIntensity.Int5Lower) ? color : state.int5Lower,
      int5Upper:
          (intensity == JmaIntensity.Int5Upper) ? color : state.int5Upper,
      int6Lower:
          (intensity == JmaIntensity.Int6Lower) ? color : state.int6Lower,
      int6Upper:
          (intensity == JmaIntensity.Int6Upper) ? color : state.int6Upper,
      int7: (intensity == JmaIntensity.Int7) ? color : state.int7,
      over: (intensity == JmaIntensity.over) ? color : state.over,
      error: (intensity == JmaIntensity.Error) ? color : state.error,
    );
  }

  Future<void> set(JmaIntensity intensity, Color color) async {
    final prefs = ref.read(sharedPreferencesProvder);
    await prefs.setInt(
      intensity.toString(),
      color.value,
    );
    state = state.copyWith(
      unknown: (intensity == JmaIntensity.Unknown) ? color : state.unknown,
      int0: (intensity == JmaIntensity.Int0) ? color : state.int0,
      int1: (intensity == JmaIntensity.Int1) ? color : state.int1,
      int2: (intensity == JmaIntensity.Int2) ? color : state.int2,
      int3: (intensity == JmaIntensity.Int3) ? color : state.int3,
      int4: (intensity == JmaIntensity.Int4) ? color : state.int4,
      int5Lower:
          (intensity == JmaIntensity.Int5Lower) ? color : state.int5Lower,
      int5Upper:
          (intensity == JmaIntensity.Int5Upper) ? color : state.int5Upper,
      int6Lower:
          (intensity == JmaIntensity.Int6Lower) ? color : state.int6Lower,
      int6Upper:
          (intensity == JmaIntensity.Int6Upper) ? color : state.int6Upper,
      int7: (intensity == JmaIntensity.Int7) ? color : state.int7,
      over: (intensity == JmaIntensity.over) ? color : state.over,
      error: (intensity == JmaIntensity.Error) ? color : state.error,
    );
  }

  Future<void> reset() async {
    state = state.copyWith(
      unknown: JmaIntensity.Unknown.color,
      int0: JmaIntensity.Int0.color,
      int1: JmaIntensity.Int1.color,
      int2: JmaIntensity.Int2.color,
      int3: JmaIntensity.Int3.color,
      int4: JmaIntensity.Int4.color,
      int5Lower: JmaIntensity.Int5Lower.color,
      int5Upper: JmaIntensity.Int5Upper.color,
      int6Lower: JmaIntensity.Int6Lower.color,
      int6Upper: JmaIntensity.Int6Upper.color,
      int7: JmaIntensity.Int7.color,
      over: JmaIntensity.over.color,
      error: JmaIntensity.Error.color,
    );
    await saveAll();
  }
}
