import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';

class EewWarningOverlayLabelFormatter {
  const EewWarningOverlayLabelFormatter();

  String bannerLabel({
    required EewWarningOverlaySource source,
    required String reportLabel,
  }) => switch (source) {
    EewWarningOverlaySource.real => '緊急地震速報（警報）',
    EewWarningOverlaySource.simulation => reportLabel,
  };

  String semanticsLabel({required EewWarningOverlaySource source}) =>
      switch (source) {
        EewWarningOverlaySource.real => '緊急地震速報警報',
        EewWarningOverlaySource.simulation => '訓練／シミュレーションの緊急地震速報',
      };
}
