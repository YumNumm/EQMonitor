import 'package:jma_eew_xml/src/jma_eew_xml_exception.dart';
import 'package:jma_eew_xml/src/model/jma_code_name.dart';
import 'package:jma_eew_xml/src/model/jma_eew_enums.dart';
import 'package:jma_eew_xml/src/model/jma_eew_intensity_forecast.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_reader.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tag.dart';

final class const JmaEewIntensityForecastReader(final JmaXmlReader reader) {
  static const _over = 'over';

  JmaEewIntensityForecast read(int forecast) {
    final tree = reader.tree;
    final lgInt = tree.child(forecast, JmaXmlTag.forecastLgInt);
    final appendix = tree.child(forecast, JmaXmlTag.appendix);
    final areas = <JmaEewForecastArea>[];
    for (
      var pref = tree.firstChild(forecast);
      pref >= 0;
      pref = tree.nextSibling(pref)
    ) {
      if (tree.tag(pref) != JmaXmlTag.pref) {
        continue;
      }
      final prefecture = reader.requireCodeName(pref);
      for (
        var area = tree.firstChild(pref);
        area >= 0;
        area = tree.nextSibling(area)
      ) {
        if (tree.tag(area) == JmaXmlTag.area) {
          areas.add(readArea(area, prefecture: prefecture));
        }
      }
    }
    return JmaEewIntensityForecast(
      maxIntensity: readIntensityRange(
        reader.requireChild(forecast, JmaXmlTag.forecastInt),
      ),
      maxLgIntensity: lgInt < 0 ? null : readLgIntensityRange(lgInt),
      appendix: appendix < 0
          ? null
          : JmaEewForecastAppendix(
              maxIntChange: reader.requireInt(appendix, JmaXmlTag.maxIntChange),
              maxLgIntChange: reader.optionalInt(
                appendix,
                JmaXmlTag.maxLgIntChange,
              ),
              maxIntChangeReason: reader.requireInt(
                appendix,
                JmaXmlTag.maxIntChangeReason,
              ),
            ),
      areas: areas,
    );
  }

  JmaEewForecastArea readArea(int area, {required JmaCodeName prefecture}) {
    final tree = reader.tree;
    final category = reader.requireChild(area, JmaXmlTag.category);
    final lastKind = tree.child(category, JmaXmlTag.lastKind);
    final lgInt = tree.child(area, JmaXmlTag.forecastLgInt);
    return JmaEewForecastArea(
      prefecture: prefecture,
      code: reader.requireText(area, JmaXmlTag.code),
      name: reader.requireText(area, JmaXmlTag.name),
      kind: reader.requireCodeName(
        reader.requireChild(category, JmaXmlTag.kind),
      ),
      lastKind: lastKind < 0 ? null : reader.requireCodeName(lastKind),
      intensity: readIntensityRange(
        reader.requireChild(area, JmaXmlTag.forecastInt),
      ),
      lgIntensity: lgInt < 0 ? null : readLgIntensityRange(lgInt),
      arrivalTime: reader.optionalDateTime(area, JmaXmlTag.arrivalTime),
      condition: reader.nonEmptyText(area, JmaXmlTag.condition),
    );
  }

  JmaEewIntensityRange readIntensityRange(int range) {
    final from = reader.requireText(range, JmaXmlTag.from);
    final to = reader.requireText(range, JmaXmlTag.to);
    return JmaEewIntensityRange(
      from: JmaEewIntensity.fromCode(from) ?? _invalid('From', from),
      to: to == _over
          ? null
          : JmaEewIntensity.fromCode(to) ?? _invalid('To', to),
    );
  }

  JmaEewLgIntensityRange readLgIntensityRange(int range) {
    final from = reader.requireText(range, JmaXmlTag.from);
    final to = reader.requireText(range, JmaXmlTag.to);
    return JmaEewLgIntensityRange(
      from: JmaEewLgIntensity.fromCode(from) ?? _invalid('From', from),
      to: to == _over
          ? null
          : JmaEewLgIntensity.fromCode(to) ?? _invalid('To', to),
    );
  }

  Never _invalid(String element, String value) =>
      throw JmaEewXmlStructureException('$element 要素の値を読めません: $value');
}
