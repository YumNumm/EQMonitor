extension JmaForecastIntensityPlusMinusConverter on String {
  String get fromPlusMinus => replaceAll('+', '強').replaceAll('-', '弱');
}
