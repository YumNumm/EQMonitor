import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_grade.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/similar_earthquake_gauge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

int _litCount(WidgetTester tester) => tester
    .widgetList<SimilarityGaugeCell>(find.byType(SimilarityGaugeCell))
    .where((cell) => cell.lit)
    .length;

void main() {
  testWidgets('グレードCは3セル点灯', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SimilarEarthquakeGauge(grade: SimilarityGrade.c),
        ),
      ),
    );
    expect(find.byType(SimilarityGaugeCell), findsNWidgets(5));
    expect(_litCount(tester), 3);
    expect(find.text('C'), findsOneWidget);
  });

  testWidgets('グレードAは5セル全点灯', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SimilarEarthquakeGauge(grade: SimilarityGrade.a),
        ),
      ),
    );
    expect(_litCount(tester), 5);
  });

  testWidgets('グレードEは1セル点灯', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SimilarEarthquakeGauge(grade: SimilarityGrade.e),
        ),
      ),
    );
    expect(_litCount(tester), 1);
  });
}
