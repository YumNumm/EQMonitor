/// JMA Disaster Category definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-2.
enum JmaDisasterCategory {
  earthquakeEarlyWarning(1, '緊急地震速報', 'Earthquake Early Warning'),
  hypocenter(2, '震源', 'Hypocenter'),
  seismicIntensity(3, '震度', 'Seismic Intensity'),
  nankaiTroughEarthquake(4, '南海トラフ地震', 'Nankai Trough Earthquake'),
  tsunami(5, '津波', 'Tsunami'),
  northwestPacificTsunami(6, '北西太平洋津波', 'Northwest Pacific Tsunami'),
  // 7: Unused
  volcano(8, '火山', 'Volcano'),
  ashFall(9, '降灰', 'Ash Fall'),
  weather(10, '気象', 'Weather'),
  flood(11, '洪水', 'Flood'),
  typhoon(12, '台風', 'Typhoon'),
  // 13: Unused
  marine(14, '海上', 'Marine');

  new(this.code, this.nameJa, this.nameEn);

  final int code;
  final String nameJa;
  final String nameEn;

  static JmaDisasterCategory fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
