import 'dart:typed_data';

enum JmaXmlTag(final String localName) {
  other(''),
  report('Report'),
  control('Control'),
  title('Title'),
  dateTime('DateTime'),
  status('Status'),
  editorialOffice('EditorialOffice'),
  head('Head'),
  reportDateTime('ReportDateTime'),
  targetDateTime('TargetDateTime'),
  eventId('EventID'),
  infoType('InfoType'),
  serial('Serial'),
  headline('Headline'),
  text('Text'),
  information('Information'),
  item('Item'),
  kind('Kind'),
  lastKind('LastKind'),
  areas('Areas'),
  area('Area'),
  name('Name'),
  code('Code'),
  body('Body'),
  earthquake('Earthquake'),
  originTime('OriginTime'),
  condition('Condition'),
  arrivalTime('ArrivalTime'),
  hypocenter('Hypocenter'),
  coordinate('Coordinate'),
  reduceName('ReduceName'),
  reduceCode('ReduceCode'),
  landOrSea('LandOrSea'),
  accuracy('Accuracy'),
  epicenter('Epicenter'),
  depth('Depth'),
  magnitudeCalculation('MagnitudeCalculation'),
  numberOfMagnitudeCalculation('NumberOfMagnitudeCalculation'),
  magnitude('Magnitude'),
  intensity('Intensity'),
  forecast('Forecast'),
  forecastInt('ForecastInt'),
  forecastLgInt('ForecastLgInt'),
  from('From'),
  to('To'),
  appendix('Appendix'),
  maxIntChange('MaxIntChange'),
  maxLgIntChange('MaxLgIntChange'),
  maxIntChangeReason('MaxIntChangeReason'),
  pref('Pref'),
  category('Category'),
  comments('Comments'),
  warningComment('WarningComment'),
  nextAdvisory('NextAdvisory');

  static const hashMask = 0x3FFFFFFF;
  static const _tableMask = 511;

  static int hashOf(String name) {
    var hash = 0;
    for (var i = 0; i < name.length; i++) {
      hash = (hash * 31 + name.codeUnitAt(i)) & hashMask;
    }
    return hash;
  }

  static final _table = () {
    final table = Int32List(_tableMask + 1);
    for (final tag in values.skip(1)) {
      var slot = hashOf(tag.localName) & _tableMask;
      while (table[slot] != 0) {
        slot = (slot + 1) & _tableMask;
      }
      table[slot] = tag.index;
    }
    return table;
  }();

  static final _hashes = Int32List.fromList([
    for (final tag in values) hashOf(tag.localName),
  ]);

  /// 字句解析で計算済みの [hash]（[hashOf] と同じ計算）で候補を引き、文字を照合して確定する。
  static JmaXmlTag lookup(String source, int start, int end, int hash) {
    final length = end - start;
    var slot = hash & _tableMask;
    while (true) {
      final index = _table[slot];
      if (index == 0) {
        return other;
      }
      if (_hashes[index] == hash) {
        final name = values[index].localName;
        if (name.length == length && _matches(source, start, name)) {
          return values[index];
        }
      }
      slot = (slot + 1) & _tableMask;
    }
  }

  static bool _matches(String source, int start, String name) {
    for (var k = 0; k < name.length; k++) {
      if (source.codeUnitAt(start + k) != name.codeUnitAt(k)) {
        return false;
      }
    }
    return true;
  }
}
