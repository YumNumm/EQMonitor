import 'package:jma_eew_xml/src/model/jma_code_name.dart';
import 'package:jma_eew_xml/src/model/jma_eew_enums.dart';

final class const JmaEewIntensityRange({
  required final JmaEewIntensity from,
  required final JmaEewIntensity? to,
}) {
  bool get isOver => to == null;
}

final class const JmaEewLgIntensityRange({
  required final JmaEewLgIntensity from,
  required final JmaEewLgIntensity? to,
}) {
  bool get isOver => to == null;
}

final class const JmaEewIntensityForecast({
  required final JmaEewIntensityRange maxIntensity,
  required final JmaEewLgIntensityRange? maxLgIntensity,
  required final JmaEewForecastAppendix? appendix,
  required final List<JmaEewForecastArea> areas,
});

final class const JmaEewForecastAppendix({
  required final int maxIntChange,
  required final int? maxLgIntChange,
  required final int maxIntChangeReason,
});

final class const JmaEewForecastArea({
  required final JmaCodeName prefecture,
  required final String code,
  required final String name,
  required final JmaCodeName kind,
  required final JmaCodeName? lastKind,
  required final JmaEewIntensityRange intensity,
  required final JmaEewLgIntensityRange? lgIntensity,
  required final DateTime? arrivalTime,
  required final String? condition,
}) {
  static const arrivedCondition = '既に主要動到達と推測';

  bool get isWarning => kind.code.startsWith('1');

  bool get isPlum => kind.code.endsWith('9');

  bool get isArrived => condition == arrivedCondition;
}
