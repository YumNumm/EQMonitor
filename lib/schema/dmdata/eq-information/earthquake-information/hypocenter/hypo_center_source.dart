enum HypoCenterSource {
  usgs('USGS'),
  ptwc('PTWC'),
  watwc('WCATWC');

  const HypoCenterSource(this.description);

  final String description;
}
