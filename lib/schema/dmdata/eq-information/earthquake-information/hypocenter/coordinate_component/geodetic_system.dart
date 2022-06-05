enum GeodeticSystem {
  worldGeodeticSystem('世界測地系'),

  japaneseGeodeticSystem('日本測地系');

  const GeodeticSystem(this.description);

  final String description;
}
