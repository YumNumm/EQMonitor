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
        ) {
    prefs = ref.watch(sharedPreferencesProvder);
  }

  final Ref ref;
  late SharedPreferences prefs;

  void load() {
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
    );
  }

  static JmaIntensityColorModel loadFromPrefs(
    SharedPreferences prefs,
  ) {
    final unknown = prefs.getInt(JmaIntensity.unknown.toString());
    final int0 = prefs.getInt(JmaIntensity.int0.toString());
    final int1 = prefs.getInt(JmaIntensity.int1.toString());
    final int2 = prefs.getInt(JmaIntensity.int2.toString());
    final int3 = prefs.getInt(JmaIntensity.int3.toString());
    final int4 = prefs.getInt(JmaIntensity.int4.toString());
    final int5Lower = prefs.getInt(JmaIntensity.int5Lower.toString());
    final int5Upper = prefs.getInt(JmaIntensity.int5Upper.toString());
    final int6Lower = prefs.getInt(JmaIntensity.int6Lower.toString());
    final int6Upper = prefs.getInt(JmaIntensity.int6Upper.toString());
    final int7 = prefs.getInt(JmaIntensity.int7.toString());
    final over = prefs.getInt(JmaIntensity.over.toString());
    final notRecievedYet = prefs.getInt(JmaIntensity.notRecievedYet.toString());

    return JmaIntensityColorModel(
      unknown: (unknown == null) ? JmaIntensity.unknown.color : Color(unknown),
      int0: (int0 == null) ? JmaIntensity.int0.color : Color(int0),
      int1: (int1 == null) ? JmaIntensity.int1.color : Color(int1),
      int2: (int2 == null) ? JmaIntensity.int2.color : Color(int2),
      int3: (int3 == null) ? JmaIntensity.int3.color : Color(int3),
      int4: (int4 == null) ? JmaIntensity.int4.color : Color(int4),
      int5Lower:
          (int5Lower == null) ? JmaIntensity.int5Lower.color : Color(int5Lower),
      int5Upper:
          (int5Upper == null) ? JmaIntensity.int5Upper.color : Color(int5Upper),
      int6Lower:
          (int6Lower == null) ? JmaIntensity.int6Lower.color : Color(int6Lower),
      int6Upper:
          (int6Upper == null) ? JmaIntensity.int6Upper.color : Color(int6Upper),
      int7: (int7 == null) ? JmaIntensity.int7.color : Color(int7),
      over: (over == null) ? JmaIntensity.over.color : Color(over),
      notRecievedYet: (notRecievedYet == null)
          ? JmaIntensity.notRecievedYet.color
          : Color(notRecievedYet),
    );
  }

  Future<void> saveAll() async {
    await prefs.setInt(JmaIntensity.unknown.toString(), state.unknown.value);
    await prefs.setInt(JmaIntensity.int0.toString(), state.int0.value);
    await prefs.setInt(JmaIntensity.int1.toString(), state.int1.value);
    await prefs.setInt(JmaIntensity.int2.toString(), state.int2.value);
    await prefs.setInt(JmaIntensity.int3.toString(), state.int3.value);
    await prefs.setInt(JmaIntensity.int4.toString(), state.int4.value);
    await prefs.setInt(
      JmaIntensity.int5Lower.toString(),
      state.int5Lower.value,
    );
    await prefs.setInt(
      JmaIntensity.int5Upper.toString(),
      state.int5Upper.value,
    );
    await prefs.setInt(
      JmaIntensity.int6Lower.toString(),
      state.int6Lower.value,
    );
    await prefs.setInt(
      JmaIntensity.int6Upper.toString(),
      state.int6Upper.value,
    );
    await prefs.setInt(JmaIntensity.int7.toString(), state.int7.value);
    await prefs.setInt(JmaIntensity.over.toString(), state.over.value);
  }

  void change(JmaIntensity intensity, Color color) {
    state = state.copyWith(
      unknown: (intensity == JmaIntensity.unknown) ? color : state.unknown,
      int0: (intensity == JmaIntensity.int0) ? color : state.int0,
      int1: (intensity == JmaIntensity.int1) ? color : state.int1,
      int2: (intensity == JmaIntensity.int2) ? color : state.int2,
      int3: (intensity == JmaIntensity.int3) ? color : state.int3,
      int4: (intensity == JmaIntensity.int4) ? color : state.int4,
      int5Lower:
          (intensity == JmaIntensity.int5Lower) ? color : state.int5Lower,
      int5Upper:
          (intensity == JmaIntensity.int5Upper) ? color : state.int5Upper,
      int6Lower:
          (intensity == JmaIntensity.int6Lower) ? color : state.int6Lower,
      int6Upper:
          (intensity == JmaIntensity.int6Upper) ? color : state.int6Upper,
      int7: (intensity == JmaIntensity.int7) ? color : state.int7,
      over: (intensity == JmaIntensity.over) ? color : state.over,
    );
  }

  Future<void> set(JmaIntensity intensity, Color color) async {
    await prefs.setInt(
      intensity.toString(),
      color.value,
    );
    state = state.copyWith(
      unknown: (intensity == JmaIntensity.unknown) ? color : state.unknown,
      int0: (intensity == JmaIntensity.int0) ? color : state.int0,
      int1: (intensity == JmaIntensity.int1) ? color : state.int1,
      int2: (intensity == JmaIntensity.int2) ? color : state.int2,
      int3: (intensity == JmaIntensity.int3) ? color : state.int3,
      int4: (intensity == JmaIntensity.int4) ? color : state.int4,
      int5Lower:
          (intensity == JmaIntensity.int5Lower) ? color : state.int5Lower,
      int5Upper:
          (intensity == JmaIntensity.int5Upper) ? color : state.int5Upper,
      int6Lower:
          (intensity == JmaIntensity.int6Lower) ? color : state.int6Lower,
      int6Upper:
          (intensity == JmaIntensity.int6Upper) ? color : state.int6Upper,
      int7: (intensity == JmaIntensity.int7) ? color : state.int7,
      over: (intensity == JmaIntensity.over) ? color : state.over,
    );
  }

  Future<void> reset() async {
    state = state.copyWith(
      unknown: JmaIntensity.unknown.color,
      int0: JmaIntensity.int0.color,
      int1: JmaIntensity.int1.color,
      int2: JmaIntensity.int2.color,
      int3: JmaIntensity.int3.color,
      int4: JmaIntensity.int4.color,
      int5Lower: JmaIntensity.int5Lower.color,
      int5Upper: JmaIntensity.int5Upper.color,
      int6Lower: JmaIntensity.int6Lower.color,
      int6Upper: JmaIntensity.int6Upper.color,
      int7: JmaIntensity.int7.color,
      over: JmaIntensity.over.color,
    );
    await saveAll();
  }
}
