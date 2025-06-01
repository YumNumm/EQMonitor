import 'dart:ui';

import 'package:eqmonitor/core/extension/color_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorCode拡張機能のテスト', () {
    test('hex - 赤色のhex値が正しく取得できること', () {
      // Arrange - テストの準備
      const color = Color(0xFFFF0000); // 赤色

      // Act - テスト対象の機能を実行
      final result = color.hex;

      // Assert - 結果を検証
      expect(result, 0xFF0000);
    });

    test('hex - 緑色のhex値が正しく取得できること', () {
      // Arrange
      const color = Color(0xFF00FF00); // 緑色

      // Act
      final result = color.hex;

      // Assert
      expect(result, 0x00FF00);
    });

    test('hex - 青色のhex値が正しく取得できること', () {
      // Arrange
      const color = Color(0xFF0000FF); // 青色

      // Act
      final result = color.hex;

      // Assert
      expect(result, 0x0000FF);
    });

    test('hex - 黒色のhex値が正しく取得できること', () {
      // Arrange
      const color = Color(0xFF000000); // 黒色

      // Act
      final result = color.hex;

      // Assert
      expect(result, 0x000000);
    });

    test('hex - 白色のhex値が正しく取得できること', () {
      // Arrange
      const color = Color(0xFFFFFFFF); // 白色

      // Act
      final result = color.hex;

      // Assert
      expect(result, 0xFFFFFF);
    });
  });
}
