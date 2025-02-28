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

    test('toHexStringRGB - 赤色の16進数文字列が正しく取得できること', () {
      // Arrange
      const color = Color(0xFFFF0000); // 赤色

      // Act
      final result = color.toHexStringRGB();

      // Assert
      expect(result, '#ff0000');
    });

    test('toHexStringRGB - 緑色の16進数文字列が正しく取得できること', () {
      // Arrange
      const color = Color(0xFF00FF00); // 緑色

      // Act
      final result = color.toHexStringRGB();

      // Assert
      expect(result, '#00ff00');
    });

    test('toHexStringRGB - 青色の16進数文字列が正しく取得できること', () {
      // Arrange
      const color = Color(0xFF0000FF); // 青色

      // Act
      final result = color.toHexStringRGB();

      // Assert
      expect(result, '#0000ff');
    });

    test('toHexStringRGB - 黒色の16進数文字列が正しく取得できること', () {
      // Arrange
      const color = Color(0xFF000000); // 黒色

      // Act
      final result = color.toHexStringRGB();

      // Assert
      expect(result, '#000000');
    });

    test('toHexStringRGB - 白色の16進数文字列が正しく取得できること', () {
      // Arrange
      const color = Color(0xFFFFFFFF); // 白色

      // Act
      final result = color.toHexStringRGB();

      // Assert
      expect(result, '#ffffff');
    });

    test('toHexStringRGB - 透明度が無視されること', () {
      // Arrange
      const color1 = Color(0xFFFF0000); // 不透明な赤
      const color2 = Color(0x80FF0000); // 半透明な赤

      // Act
      final result1 = color1.toHexStringRGB();
      final result2 = color2.toHexStringRGB();

      // Assert
      expect(result1, result2); // 透明度が異なっても同じ結果になるはず
      expect(result1, '#ff0000');
    });

    test('toHexStringRGB - 1桁の16進数が0埋めされること', () {
      // Arrange
      const color = Color(0xFF010203); // RGB値が小さい色

      // Act
      final result = color.toHexStringRGB();

      // Assert
      expect(result, '#010203'); // 各値が2桁になっていること
    });
  });
}
