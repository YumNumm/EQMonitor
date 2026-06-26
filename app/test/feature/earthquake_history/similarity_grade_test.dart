import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_grade.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SimilarityGrade.fromScore', () {
    test('境界値でグレードが切り替わる', () {
      expect(SimilarityGrade.fromScore(0), SimilarityGrade.a);
      expect(SimilarityGrade.fromScore(49.9), SimilarityGrade.a);
      expect(SimilarityGrade.fromScore(50), SimilarityGrade.b);
      expect(SimilarityGrade.fromScore(99.9), SimilarityGrade.b);
      expect(SimilarityGrade.fromScore(100), SimilarityGrade.c);
      expect(SimilarityGrade.fromScore(199.9), SimilarityGrade.c);
      expect(SimilarityGrade.fromScore(200), SimilarityGrade.d);
      expect(SimilarityGrade.fromScore(349.9), SimilarityGrade.d);
      expect(SimilarityGrade.fromScore(350), SimilarityGrade.e);
      expect(SimilarityGrade.fromScore(500), SimilarityGrade.e);
      expect(SimilarityGrade.fromScore(9999), SimilarityGrade.e);
    });

    test('litCells が A=5..E=1', () {
      expect(SimilarityGrade.a.litCells, 5);
      expect(SimilarityGrade.b.litCells, 4);
      expect(SimilarityGrade.c.litCells, 3);
      expect(SimilarityGrade.d.litCells, 2);
      expect(SimilarityGrade.e.litCells, 1);
    });

    test('label が A..E', () {
      expect(SimilarityGrade.a.label, 'A');
      expect(SimilarityGrade.b.label, 'B');
      expect(SimilarityGrade.c.label, 'C');
      expect(SimilarityGrade.d.label, 'D');
      expect(SimilarityGrade.e.label, 'E');
    });
  });
}
