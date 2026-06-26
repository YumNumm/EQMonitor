import 'package:flutter/material.dart';

/// 類似度グレード。
///
/// backendが返す`score`(km相当の距離スコア、小さいほど類似)を5段階に分類する。
enum SimilarityGrade {
  a,
  b,
  c,
  d,
  e;

  /// `score`からグレードを導出する。
  ///
  /// 閾値: A:`<50` / B:`<100` / C:`<200` / D:`<350` / E:`それ以上`。
  static SimilarityGrade fromScore(num score) {
    if (score < 50) {
      return SimilarityGrade.a;
    }
    if (score < 100) {
      return SimilarityGrade.b;
    }
    if (score < 200) {
      return SimilarityGrade.c;
    }
    if (score < 350) {
      return SimilarityGrade.d;
    }
    return SimilarityGrade.e;
  }

  /// 5セルゲージで点灯するセル数(類似度が高いほど多い)。
  int get litCells => switch (this) {
    SimilarityGrade.a => 5,
    SimilarityGrade.b => 4,
    SimilarityGrade.c => 3,
    SimilarityGrade.d => 2,
    SimilarityGrade.e => 1,
  };

  String get label => switch (this) {
    SimilarityGrade.a => 'A',
    SimilarityGrade.b => 'B',
    SimilarityGrade.c => 'C',
    SimilarityGrade.d => 'D',
    SimilarityGrade.e => 'E',
  };

  /// グレード色(A:緑 → E:赤)。
  Color get color => switch (this) {
    SimilarityGrade.a => const Color(0xFF2E7D32),
    SimilarityGrade.b => const Color(0xFF689F38),
    SimilarityGrade.c => const Color(0xFFF9A825),
    SimilarityGrade.d => const Color(0xFFEF6C00),
    SimilarityGrade.e => const Color(0xFFC62828),
  };
}
