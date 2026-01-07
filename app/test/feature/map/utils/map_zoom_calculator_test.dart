import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calculateZoomLevel', () {
    test('日本全国の範囲で適切なズームレベルが計算されること', () {
      // Arrange - 日本全国の緯度経度範囲
      const minLat = JapanBounds.minLat; // 24.0
      const maxLat = JapanBounds.maxLat; // 46.0
      const minLng = JapanBounds.minLng; // 122.5
      const maxLng = JapanBounds.maxLng; // 146.0
      const screenWidth = 375.0; // iPhone標準サイズ
      const screenHeight = 667.0;

      // Act
      final zoom = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 日本全国が見える程度のズームレベル（4～6程度）
      expect(zoom, greaterThan(3.0));
      expect(zoom, lessThan(7.0));
    });

    test('小さい範囲（東京周辺）で高いズームレベルが計算されること', () {
      // Arrange - 東京周辺の狭い範囲
      const minLat = 35.5;
      const maxLat = 35.8;
      const minLng = 139.5;
      const maxLng = 139.9;
      const screenWidth = 375.0;
      const screenHeight = 667.0;

      // Act
      final zoom = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 狭い範囲なので高いズームレベル（10以上）
      expect(zoom, greaterThan(9.0));
    });

    test('大きい範囲（世界全体）で低いズームレベルが計算されること', () {
      // Arrange - 世界全体
      const minLat = -85.0;
      const maxLat = 85.0;
      const minLng = -180.0;
      const maxLng = 180.0;
      const screenWidth = 375.0;
      const screenHeight = 667.0;

      // Act
      final zoom = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 世界全体なので低いズームレベル（2以下）
      expect(zoom, lessThan(2.0));
    });

    test('横長の画面で適切なズームレベルが計算されること', () {
      // Arrange - タブレット横向き
      const minLat = JapanBounds.minLat;
      const maxLat = JapanBounds.maxLat;
      const minLng = JapanBounds.minLng;
      const maxLng = JapanBounds.maxLng;
      const screenWidth = 1024.0;
      const screenHeight = 768.0;

      // Act
      final zoom = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 画面が大きいのでスマホより高いズームレベル
      expect(zoom, greaterThan(4.0));
      expect(zoom, lessThan(8.0));
    });

    test('縦長の画面で適切なズームレベルが計算されること', () {
      // Arrange - スマホ縦向き
      const minLat = JapanBounds.minLat;
      const maxLat = JapanBounds.maxLat;
      const minLng = JapanBounds.minLng;
      const maxLng = JapanBounds.maxLng;
      const screenWidth = 375.0;
      const screenHeight = 812.0; // iPhone X系

      // Act
      final zoom = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 縦長なので日本全国が見える程度のズームレベル
      expect(zoom, greaterThan(3.0));
      expect(zoom, lessThan(7.0));
    });

    test('経度方向が制約となる場合のズームレベル計算', () {
      // Arrange - 横に広い範囲
      const minLat = 35.0;
      const maxLat = 36.0; // 緯度差1度
      const minLng = 130.0;
      const maxLng = 145.0; // 経度差15度
      const screenWidth = 375.0;
      const screenHeight = 667.0;

      // Act
      final zoom = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 横に広いので経度方向が制約
      expect(zoom, greaterThan(5.0));
      expect(zoom, lessThan(9.0));
    });

    test('緯度方向が制約となる場合のズームレベル計算', () {
      // Arrange - 縦に広い範囲
      const minLat = 25.0;
      const maxLat = 45.0; // 緯度差20度
      const minLng = 139.0;
      const maxLng = 141.0; // 経度差2度
      const screenWidth = 375.0;
      const screenHeight = 667.0;

      // Act
      final zoom = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 縦に広いので緯度方向が制約
      expect(zoom, greaterThan(5.0));
      expect(zoom, lessThan(9.0));
    });

    test('緯度差が極端に小さい場合でもエラーにならないこと', () {
      // Arrange - 緯度差がほぼゼロ
      const minLat = 35.6895;
      const maxLat = 35.6895; // 同じ緯度
      const minLng = 139.0;
      const maxLng = 140.0;
      const screenWidth = 375.0;
      const screenHeight = 667.0;

      // Act & Assert - エラーにならずに計算できること
      expect(
        () => calculateZoomLevel(
          minLat: minLat,
          maxLat: maxLat,
          minLng: minLng,
          maxLng: maxLng,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        returnsNormally,
      );
    });

    test('国際日付変更線を跨ぐ場合の経度計算', () {
      // Arrange - 国際日付変更線付近
      const minLat = 30.0;
      const maxLat = 40.0;
      const minLng = 170.0;
      const maxLng = -170.0; // マイナスなので跨いでいる
      const screenWidth = 375.0;
      const screenHeight = 667.0;

      // Act
      final zoom = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 適切なズームレベルが計算されること
      expect(zoom, isPositive);
      expect(zoom.isFinite, isTrue);
    });

    test('同じ画面サイズでは経度・緯度範囲が大きいほどズームレベルが小さいこと', () {
      // Arrange
      const screenWidth = 375.0;
      const screenHeight = 667.0;

      // Act - 小さい範囲
      final zoomSmall = calculateZoomLevel(
        minLat: 35.0,
        maxLat: 36.0,
        minLng: 139.0,
        maxLng: 140.0,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Act - 大きい範囲
      final zoomLarge = calculateZoomLevel(
        minLat: 30.0,
        maxLat: 45.0,
        minLng: 130.0,
        maxLng: 145.0,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );

      // Assert - 範囲が大きいほどズームレベルが小さい
      expect(zoomSmall, greaterThan(zoomLarge));
    });

    test('画面サイズが大きいほどズームレベルが大きいこと', () {
      // Arrange - 同じ緯度経度範囲
      const minLat = JapanBounds.minLat;
      const maxLat = JapanBounds.maxLat;
      const minLng = JapanBounds.minLng;
      const maxLng = JapanBounds.maxLng;

      // Act - 小さい画面
      final zoomSmall = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: 375.0,
        screenHeight: 667.0,
      );

      // Act - 大きい画面
      final zoomLarge = calculateZoomLevel(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        screenWidth: 1920.0,
        screenHeight: 1080.0,
      );

      // Assert - 画面が大きいほどズームレベルが大きい
      expect(zoomLarge, greaterThan(zoomSmall));
    });
  });

  group('JapanBounds', () {
    test('中心座標が正しく計算されていること', () {
      // Assert
      expect(
        JapanBounds.centerLat,
        equals((JapanBounds.minLat + JapanBounds.maxLat) / 2),
      );
      expect(
        JapanBounds.centerLng,
        equals((JapanBounds.minLng + JapanBounds.maxLng) / 2),
      );
    });

    test('緯度経度範囲が妥当であること', () {
      // Assert - 緯度は-90～90の範囲内
      expect(JapanBounds.minLat, greaterThanOrEqualTo(-90));
      expect(JapanBounds.maxLat, lessThanOrEqualTo(90));

      // Assert - 経度は-180～180の範囲内
      expect(JapanBounds.minLng, greaterThanOrEqualTo(-180));
      expect(JapanBounds.maxLng, lessThanOrEqualTo(180));

      // Assert - minがmaxより小さい
      expect(JapanBounds.minLat, lessThan(JapanBounds.maxLat));
      expect(JapanBounds.minLng, lessThan(JapanBounds.maxLng));
    });
  });
}
