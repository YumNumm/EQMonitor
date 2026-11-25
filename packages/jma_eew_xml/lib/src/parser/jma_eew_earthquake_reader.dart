import 'package:jma_eew_xml/src/jma_eew_xml_exception.dart';
import 'package:jma_eew_xml/src/model/jma_coordinate.dart';
import 'package:jma_eew_xml/src/model/jma_eew_earthquake.dart';
import 'package:jma_eew_xml/src/parser/jma_coordinate_parser.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_reader.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tag.dart';

final class const JmaEewEarthquakeReader(final JmaXmlReader reader) {
  static const _coordinateParser = JmaCoordinateParser();

  JmaEewEarthquake read(int earthquake) {
    final hypocenter = reader.requireChild(earthquake, JmaXmlTag.hypocenter);
    return JmaEewEarthquake(
      originTime: reader.optionalDateTime(earthquake, JmaXmlTag.originTime),
      arrivalTime: reader.requireDateTime(earthquake, JmaXmlTag.arrivalTime),
      condition: reader.nonEmptyText(earthquake, JmaXmlTag.condition),
      hypocenter: readHypocenter(hypocenter),
      magnitude: readMagnitude(
        reader.requireChild(earthquake, JmaXmlTag.magnitude),
      ),
    );
  }

  JmaEewHypocenter readHypocenter(int hypocenter) {
    final tree = reader.tree;
    final area = reader.requireChild(hypocenter, JmaXmlTag.area);
    final coordinate = tree.child(area, JmaXmlTag.coordinate);
    final accuracy = tree.child(hypocenter, JmaXmlTag.accuracy);
    return JmaEewHypocenter(
      code: reader.requireText(area, JmaXmlTag.code),
      name: reader.requireText(area, JmaXmlTag.name),
      coordinate: coordinate < 0
          ? null
          : _parseCoordinate(
              tree.text(coordinate),
              datum: tree.attribute(coordinate, 'datum'),
            ),
      coordinateDescription: coordinate < 0
          ? null
          : tree.attribute(coordinate, 'description'),
      reduceCode: reader.nonEmptyText(area, JmaXmlTag.reduceCode),
      reduceName: reader.nonEmptyText(area, JmaXmlTag.reduceName),
      landOrSea: reader.nonEmptyText(area, JmaXmlTag.landOrSea),
      accuracy: accuracy < 0 ? null : readAccuracy(accuracy),
    );
  }

  JmaEewAccuracy readAccuracy(int accuracy) {
    final epicenter = reader.requireChild(accuracy, JmaXmlTag.epicenter);
    return JmaEewAccuracy(
      epicenterRank: reader.requireIntAttribute(epicenter, 'rank'),
      epicenterRank2: reader.requireIntAttribute(epicenter, 'rank2'),
      depthRank: reader.requireIntAttribute(
        reader.requireChild(accuracy, JmaXmlTag.depth),
        'rank',
      ),
      magnitudeCalculationRank: reader.requireIntAttribute(
        reader.requireChild(accuracy, JmaXmlTag.magnitudeCalculation),
        'rank',
      ),
      numberOfMagnitudeCalculation: reader.requireInt(
        accuracy,
        JmaXmlTag.numberOfMagnitudeCalculation,
      ),
    );
  }

  JmaEewMagnitude readMagnitude(int magnitude) {
    final tree = reader.tree;
    final value = double.tryParse(tree.text(magnitude).trim());
    return JmaEewMagnitude(
      value: value == null || value.isNaN ? null : value,
      type: tree.attribute(magnitude, 'type'),
      condition: tree.attribute(magnitude, 'condition'),
      description: tree.attribute(magnitude, 'description'),
    );
  }

  JmaCoordinate? _parseCoordinate(
    String text, {
    required String? datum,
  }) {
    try {
      return _coordinateParser.parse(text, datum: datum);
    } on FormatException catch (error) {
      throw JmaEewXmlStructureException(error.message);
    }
  }
}
