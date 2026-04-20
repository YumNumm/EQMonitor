import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';

class RealtimeDataTypeInfoDialog {
  const RealtimeDataTypeInfoDialog._();

  static Future<void> show(BuildContext context) =>
      AdaptiveAlertDialog.show(
        context: context,
        title: '強震モニタのデータ種別について',
        message: '''
リアルタイム震度
防災科研が独自に開発した逐次的に計算される目安の震度を表示します。本来揺れが収まった後に計算されて発表される「震度」にほぼ一致する特徴があります。

最大加速度 (PGA)
強震計が実際に観測している揺れの加速度の直近1秒間の最大値を表示します。3方向（北―南、東―西、上―下）をベクトル合成した波形の最大値となります。

最大速度 (PGV)
揺れの加速度を積分して得られる速度の1秒毎の最大値を表示します。

最大変位 (PGD)
揺れの加速度を2回積分して得られる変位の1秒毎の最大値を表示します。

速度応答（0.125、0.25、0.5、1.0、2.0、4.0Hz）
各周波数成分についての速度応答波形（減衰5%）の1秒毎の最大値を表示します。低い周波数（0.125 Hz側）はゆっくりとした揺れの、高い周波数（4.0 Hz側）は速い揺れの強さを示します。

出典: 強震モニタについて - 防災科研''',
        actions: [
          AlertAction(
            title: '閉じる',
            onPressed: () {},
            style: AlertActionStyle.cancel,
          ),
        ],
      );
}
