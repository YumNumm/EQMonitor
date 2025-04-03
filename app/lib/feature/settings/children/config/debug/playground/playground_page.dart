// cf. https://gist.github.com/YumNumm/3433d5e1f522d512f88f3608a921dcb4

// ignore_for_file: avoid_classes_with_only_static_members, parameter_assignments

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // 追加
import 'package:go_router/go_router.dart';

// ignore: unreachable_from_main
class PlaygroundRoute extends GoRouteData {
  // ignore: unreachable_from_main
  const PlaygroundRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlaygroundPage();
  }
}

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const PlaygroundPage()),
      ],
    );
    return MaterialApp.router(
      title: 'Kyoshin Monitor Color Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}

/// メインメニュー
class PlaygroundPage extends StatelessWidget {
  const PlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground')),
      body: Column(
        children: [
          ListTile(
            title: const Text('ScaleCheckList'),
            onTap:
                () async => showDialog(
                  context: context,
                  builder:
                      (context) => Scaffold(
                        appBar: AppBar(title: const Text('ScaleCheckList')),
                        body: const ScaleCheckList(),
                      ),
                ),
          ),
          ListTile(
            title: const Text('KyoshinMonitorScaleColorPage'),
            onTap:
                () async => showDialog(
                  context: context,
                  builder: (context) => const KyoshinMonitorScaleColorPage(),
                ),
          ),
        ],
      ),
    );
  }
}

/// ***************************************************************************
/// ************* 多機能ユーティリティ: パラメータ<->p<->Color ***************
/// ***************************************************************************

enum ParamType { shindo, pga, pgv, pgd }

class KyoshinMonitorScaleUtil {
  //==== (1) パラメータ (震度/PGA/PGV/PGD) -> p の変換 ====//
  static double paramToScalePosition(ParamType type, double value) {
    switch (type) {
      case ParamType.shindo:
        // p=(I+3)/10
        return (value + 3.0) / 10.0;
      case ParamType.pga:
        if (value <= 0) {
          return 0;
        }
        return (math.log(value) / math.log(10) + 2) / 5;
      case ParamType.pgv:
        if (value <= 0) {
          return 0;
        }
        return (math.log(value) / math.log(10) + 3) / 5;
      case ParamType.pgd:
        if (value <= 0) {
          return 0;
        }
        return (math.log(value) / math.log(10) + 4) / 5;
    }
  }

  static double scaleToParam(ParamType type, double p) {
    switch (type) {
      case ParamType.shindo:
        return p * 10 - 3;
      case ParamType.pga:
        return math.pow(10, p * 5 - 2).toDouble();
      case ParamType.pgv:
        return math.pow(10, p * 5 - 3).toDouble();
      case ParamType.pgd:
        return math.pow(10, p * 5 - 4).toDouble();
    }
  }

  //==== (2) p -> Color ====//
  static Color scaleToColor(double p) {
    assert(p >= 0 && p <= 1, 'p must be in [0,1]');

    var h = 0.0;
    const s = 1.0;
    var v = 1.0;

    if (p <= 0.60) {
      // A区間
      h = _solveMonotonicallyDecreasing(p, 0.1476, 1, _fA);
    } else if (p <= 0.90) {
      // B区間
      h = _solveMonotonicallyDecreasing(p, 0.001, 0.1476, _fB);
    } else {
      // C区間
      h = 0.0;
      v = _solveMonotonicallyDecreasing(p, 0, 1, _fC);
    }

    final hueDeg = h * 360.0;
    final hsv = HSVColor.fromAHSV(1, hueDeg, s, v);
    return hsv.toColor();
  }

  //==== (3) Color -> p ====//
  static double colorToScalePosition(Color color) {
    final hsv = HSVColor.fromColor(color);
    final hDeg = hsv.hue;
    final s = hsv.saturation;
    final v = hsv.value;

    if (v <= 0.1 || s <= 0.75) {
      return 0;
    }

    final h = hDeg / 360.0;
    double p;
    if (h > 0.1476) {
      p = _fA(h);
    } else if (h > 0.001) {
      p = _fB(h);
    } else {
      p = _fC(v);
    }
    if (p < 0) {
      p = 0;
    }
    if (p > 1) {
      p = 1;
    }
    return p;
  }

  //==== 多項式 ====//
  static double _fA(double h) {
    return 280.31 * math.pow(h, 6) -
        916.05 * math.pow(h, 5) +
        1142.60 * math.pow(h, 4) -
        709.95 * math.pow(h, 3) +
        234.65 * math.pow(h, 2) -
        40.27 * h +
        3.2217;
  }

  static double _fB(double h) {
    return 151.4 * math.pow(h, 4) -
        49.32 * math.pow(h, 3) +
        6.753 * math.pow(h, 2) -
        2.481 * h +
        0.9033;
  }

  static double _fC(double v) {
    return -0.005171 * math.pow(v, 2) - 0.3282 * v + 1.2236;
  }

  //==== 二分法で単調減少多項式を解く ====//
  static double _solveMonotonicallyDecreasing(
    double target,
    double lower,
    double upper,
    double Function(double) f,
  ) {
    final fL = f(lower);
    final fU = f(upper);
    if (target >= fL) {
      return lower;
    }
    if (target <= fU) {
      return upper;
    }

    for (var i = 0; i < 30; i++) {
      final mid = 0.5 * (lower + upper);
      final fM = f(mid);
      if ((fM - target).abs() < 1e-7) {
        return mid;
      }
      if (fM > target) {
        lower = mid;
      } else {
        upper = mid;
      }
    }
    return 0.5 * (lower + upper);
  }
}

class ScaleCheckList extends StatelessWidget {
  const ScaleCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    final pValues = List.generate(101, (i) => i * 0.01);

    return ListView.builder(
      itemCount: pValues.length,
      itemBuilder: (context, index) {
        final p = pValues[index];
        final color = KyoshinMonitorScaleUtil.scaleToColor(p);
        final p2 = KyoshinMonitorScaleUtil.colorToScalePosition(color);
        final diff = p2 - p;

        final absDiff = diff.abs();
        final textColor =
            (absDiff < 0.002)
                ? Colors.green
                : (absDiff < 0.01 ? Colors.orange : Colors.red);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
          child: Row(
            children: [
              Text('p=${p.toStringAsFixed(2)}  '),
              Container(
                width: 40,
                height: 20,
                color: color,
                margin: const EdgeInsets.only(right: 8),
              ),
              const Text('diff='),
              Text(
                (diff > 0 ? '+' : '') + diff.toStringAsFixed(4),
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        );
      },
    );
  }
}

class KyoshinMonitorScaleColorPage extends HookWidget {
  const KyoshinMonitorScaleColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ドロップダウンパラメータ
    final selectedType = useState<ParamType>(ParamType.shindo);

    // 入力テキスト
    final inputText = useState<String>('');

    // 計算結果の状態
    final valueParam = useState<double>(0);
    final p = useState<double>(0);
    final p2 = useState<double>(0);
    final diff = useState<double>(0);
    final color = useState<Color>(Colors.blue);
    final rgbString = useState<String>('RGB(0,0,255)');
    final diffParam = useState<double>(0);

    // 変換処理を行うローカル関数
    void onConvert() {
      final val = double.tryParse(inputText.value);
      if (val == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('入力値が数値ではありません: ${inputText.value}')),
        );
        return;
      }

      // 1) param->p
      var pTmp = KyoshinMonitorScaleUtil.paramToScalePosition(
        selectedType.value,
        val,
      );
      pTmp = pTmp.clamp(0.0, 1.0);

      // 2) p->color
      final c = KyoshinMonitorScaleUtil.scaleToColor(pTmp);

      // 3) color->p'
      final pTmp2 = KyoshinMonitorScaleUtil.colorToScalePosition(c);

      // 4) diff
      final d = pTmp2 - pTmp;

      // 5) p' -> param'
      final val2 = KyoshinMonitorScaleUtil.scaleToParam(
        selectedType.value,
        pTmp2,
      );

      // 値を更新 (useState の value にセット)
      valueParam.value = val;
      p.value = pTmp;
      color.value = c;
      p2.value = pTmp2;
      diff.value = d;
      diffParam.value = val2 - val;
      // ignore: deprecated_member_use
      rgbString.value = 'RGB(${c.r}, ${c.g}, ${c.b})';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('強震モニタ値→スケール色 変換')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //=== 1) パラメータ種別のドロップダウン ===
            Row(
              children: [
                const Text('Parameter: '),
                const SizedBox(width: 8),
                DropdownButton<ParamType>(
                  value: selectedType.value,
                  items:
                      ParamType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name),
                        );
                      }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      selectedType.value = val;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            //=== 2) テキスト入力欄 ===
            TextField(
              decoration: InputDecoration(
                labelText: 'Value (${selectedType.value})',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                inputText.value = text;
              },
            ),
            const SizedBox(height: 16),

            //=== 3) ボタン ===
            ElevatedButton(onPressed: onConvert, child: const Text('変換して表示')),
            const SizedBox(height: 24),

            //=== 4) 結果表示 ===
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 色プレビュー
                Container(width: 80, height: 80, color: color.value),
                const SizedBox(width: 16),
                // テキスト情報
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('入力値 = ${valueParam.value} (${selectedType.value})'),
                      Text('p = ${p.value.toStringAsFixed(4)}'),
                      Text("p' = ${p2.value.toStringAsFixed(5)}"),
                      Text("誤差 (p'-p) = ${diff.value.toStringAsFixed(6)}"),
                      Text(
                        "誤差 (param'-param) = ${diffParam.value.toStringAsFixed(6)}",
                      ),
                      Text(rgbString.value),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
