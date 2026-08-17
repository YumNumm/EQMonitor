/// JMA Coastal Region for Northwest Pacific Tsunami.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-28.
enum JmaCoastalRegion {
  ustKamchatsk(1, 'Ust-Kamchatsk (East Coasts of Kamchatka Peninsula)'),
  petropavlovskK(2, 'Petropavlovsk-K (East Coasts of Kamchatka Peninsula)'),
  severoKurilsk(3, 'Severo Kurilsk (Kuril Islands)'),
  urupIslands(4, 'Urup Islands (Kuril Islands)'),
  busan(5, 'Busan (South Coasts of Korean Peninsula)'),
  nohwa(6, 'Nohwa (South Coasts of Korean Peninsula)'),
  seogwipo(7, 'Seogwipo (South Coasts of Korean Peninsula)'),
  hualien(8, 'Hualien (Taiwan)'),
  basco(9, 'Basco (East Coasts of Philippines)'),
  palanan(10, 'Palanan (East Coasts of Philippines)'),
  legaspi(11, 'Legaspi (East Coasts of Philippines)'),
  laoang(12, 'Laoang (East Coasts of Philippines)'),
  madrid(13, 'Madrid (East Coasts of Philippines)'),
  davao(14, 'Davao (East Coasts of Philippines)'),
  berebere(15, 'Berebere (North Coasts of Irian Jaya)'),
  patani(16, 'Patani (North Coasts of Irian Jaya)'),
  sorong(17, 'Sorong (North Coasts of Irian Jaya)'),
  manokwari(18, 'Manokwari (North Coasts of Irian Jaya)'),
  warsa(19, 'Warsa (North Coasts of Irian Jaya)'),
  jayapura(20, 'Jayapura (North Coasts of Irian Jaya)'),
  vanimo(21, 'Vanimo (North Coasts of Papua New Guinea)'),
  wewak(22, 'Wewak (North Coasts of Papua New Guinea)'),
  madang(23, 'Madang (North Coasts of Papua New Guinea)'),
  manusIslands(24, 'Manus Islands (North Coasts of Papua New Guinea)'),
  rabaul(25, 'Rabaul (North Coasts of Papua New Guinea)'),
  kavieng(26, 'Kavieng (North Coasts of Papua New Guinea)'),
  kimbe(27, 'Kimbe (North Coasts of Papua New Guinea)'),
  kieta(28, 'Kieta (North Coasts of Papua New Guinea)'),
  guam(29, 'Guam (Mariana Islands)'),
  saipan(30, 'Saipan (Mariana Islands)'),
  malakal(31, 'Malakal (Palau)'),
  yapIsland(32, 'Yap Island (Micronesia)'),
  chuukIsland(33, 'Chuuk Island (Micronesia)'),
  pohnpeiIsland(34, 'Pohnpei Island (Micronesia)'),
  kosraeIsland(35, 'Kosrae Island (Micronesia)'),
  eniwetokIsland(36, 'Eniwetok Island (Marshall Islands)'),
  panggoe(37, 'Panggoe (North Coasts of Solomon Islands)'),
  auki(38, 'Auki (North Coasts of Solomon Islands)'),
  kirakira(39, 'Kirakira (North Coasts of Solomon Islands)'),
  munda(40, 'Munda (Solomon Sea)'),
  honiara(41, 'Honiara (Solomon Sea)'),
  ostrovKaraginskiy(
    66,
    'Ostrov-Karaginskiy (East Coasts of Kamchatka Peninsula)',
  ),
  nikolskoya(67, 'Nikolskoya (East Coasts of Kamchatka Peninsula)'),
  tongyeong(68, 'Tongyeong (South Coasts of Korean Peninsula)'),
  heuksando(69, 'Heuksando (South Coasts of Korean Peninsula)'),
  chejuIsland(70, 'Cheju-Island (South Coasts of Korean Peninsula)'),
  chilung(71, 'Chilung (Taiwan)'),
  taitung(72, 'Taitung (Taiwan)'),
  homel(74, 'Homel (Taiwan)'),
  geme(75, 'Geme (North Coasts of Irian Jaya)'),
  ulamona(76, 'Ulamona (North Coasts of Papua New Guinea)'),
  ghatere(77, 'Ghatere (North Coasts of Solomon Islands)'),
  amun(78, 'Amun (Solomon Sea)'),
  falamae(79, 'Falamae (Solomon Sea)'),
  misima(80, 'Misima (Solomon Sea)'),
  alotau(81, 'Alotau (Solomon Sea)'),
  lae(82, 'Lae (Solomon Sea)'),
  portMoresby(83, 'Port-Moresby (Coral Sea)'),
  shanghai(84, 'Shanghai (Coasts of East China Sea)'),
  zhoushan(85, 'Zhoushan (Coasts of East China Sea)'),
  wenzhou(86, 'Wenzhou (Coasts of East China Sea)'),
  unknown(99, 'Unknown'),
  otherRegion(100, 'Other region');

  new(this.code, this.nameEn);

  final int code;
  final String nameEn;

  /// Returns the coastal region for the given code.
  ///
  /// Returns null if not found.
  static JmaCoastalRegion? fromCode(int code) =>
      JmaCoastalRegion.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) =>
      'Undefined Coastal Region (Code: $code)';
}
