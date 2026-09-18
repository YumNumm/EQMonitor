import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';

/// [baseMapMaterialParametersFor]が出力する[MapMaterialParameterBlock]の
/// version。
///
/// batch互換判定はこのversionとbyte列の完全一致を見る
/// (`map_render_packet.dart`の`haveEqualMapMaterialParameterContent`)。
/// uniformの意味づけを変える改訂ではこの値を上げる。
const baseMapMaterialParameterVersion = 1;

/// Fill materialのuniform byte長(RGBA float32×4)。
const baseMapFillMaterialByteLength = 16;

/// Line materialのuniform byte長(RGBA float32×4 + 半線幅NDC float32×2)。
const baseMapLineMaterialByteLength = 24;

/// `base_map_line.fmat`の`half_width_ndc`へ渡すNDC単位の半線幅。
///
/// # 換算式
///
/// ```dart
/// halfWidthNdc = (
///   2 * halfWidthLogicalPixels / viewport.logicalSize.width,
///   2 * halfWidthLogicalPixels / viewport.logicalSize.height,
/// )
/// ```
///
/// NDCは`viewport.logicalSize`の`width × height`(logical px)に対して`[-1, 1]`
/// (全幅/全高2)を張る座標系なので、1 logical pxはNDCでx軸`2/width`、y軸
/// `2/height`に相当する。world空間では1 world px=1 logical pxで等方だが、NDCは
/// 軸ごとに正規化されているため、xとyで異なる係数を掛けて初めて画面上で等方な
/// 線幅になる(`viewProjectionMatrixFor`が組み立てる正射影はY反転と平行移動を
/// 含むaffine変換だが回転を含まない対角scaleであるため、押し出しベクトルの
/// x/y成分をこの係数で独立に掛けるだけで正しいNDCオフセットが求まる)。
///
/// # なぜNDC単位なのか(過去の不具合)
///
/// `_BaseMapController`はcamera/projectionを各tile nodeの`localTransform`へ
/// 焼き込み、Scene側cameraを恒等にしている。flutter_sceneの生成頂点shaderは
/// `world_position = model_transform * position`を`Vertex()`呼び出し**前**に
/// 計算するため、`Vertex()`が押し出しを加算する時点で`world_position`は既に
/// 実質NDC空間にある。以前この事実を見落として半線幅をlogical pixelの生値で
/// 渡しており、NDCで1.0(可視範囲±1の半分)もの押し出しとなって画面全体を
/// 線色で塗り潰していた
/// (`docs/todo/800_eqmonitor_map_deferred_verification.md`)。
///
/// **shader内でzoomから再計算しないこと。** `viewProjectionMatrixFor`のY反転・
/// 平行移動はzoomに依存せず、この値はviewportのlogical sizeだけに依存する。
/// zoom依存propertyをCPUで確定してuniformへ渡すのは設計正本の要求でもある。
({double x, double y}) baseMapLineHalfWidthNdc({
  required double halfWidthLogicalPixels,
  required MapViewport viewport,
}) {
  if (!halfWidthLogicalPixels.isFinite || halfWidthLogicalPixels < 0) {
    throw ArgumentError.value(
      halfWidthLogicalPixels,
      'halfWidthLogicalPixels',
      'must be finite and non-negative',
    );
  }
  return (
    x: 2 * halfWidthLogicalPixels / viewport.logicalSize.width,
    y: 2 * halfWidthLogicalPixels / viewport.logicalSize.height,
  );
}

/// [spec]のkindに応じたuniform blockを組み立てる。
///
/// [BaseMapLayerKind.background]は`ColoredBox`が描く背景色でありmaterialを
/// 持たないため、渡されたら`ArgumentError`にする(呼び出し側のrender plan
/// builderがbackground行を除外している契約を破っていることを意味する)。
MapMaterialParameterBlock baseMapMaterialParametersFor({
  required BaseMapLayerSpec spec,
  required double lineHalfWidthLogicalPixels,
  required MapViewport viewport,
}) => switch (spec.kind) {
  BaseMapLayerKind.background => throw ArgumentError.value(
    spec.styleLayerId,
    'spec',
    'background has no material',
  ),
  BaseMapLayerKind.fill => createMapMaterialParameterBlock(
    version: baseMapMaterialParameterVersion,
    bytes: encodeBaseMapFillMaterialBytes(color: spec.color),
  ),
  BaseMapLayerKind.line => createMapMaterialParameterBlock(
    version: baseMapMaterialParameterVersion,
    bytes: encodeBaseMapLineMaterialBytes(
      color: spec.color,
      halfWidthLogicalPixels: lineHalfWidthLogicalPixels,
      viewport: viewport,
    ),
  ),
};

/// Fill materialのuniformをlittle-endian float32のRGBAとして詰める。
Uint8List encodeBaseMapFillMaterialBytes({required Color color}) {
  final bytes = Uint8List(baseMapFillMaterialByteLength);
  _writeColor(ByteData.sublistView(bytes), color);
  return bytes;
}

/// Line materialのuniformをRGBA + 半線幅NDCとして詰める。
Uint8List encodeBaseMapLineMaterialBytes({
  required Color color,
  required double halfWidthLogicalPixels,
  required MapViewport viewport,
}) {
  final halfWidthNdc = baseMapLineHalfWidthNdc(
    halfWidthLogicalPixels: halfWidthLogicalPixels,
    viewport: viewport,
  );
  final bytes = Uint8List(baseMapLineMaterialByteLength);
  final data = ByteData.sublistView(bytes)
    ..setFloat32(16, halfWidthNdc.x, Endian.little)
    ..setFloat32(20, halfWidthNdc.y, Endian.little);
  _writeColor(data, color);
  return bytes;
}

/// [encodeBaseMapFillMaterialBytes]が詰めた値。
final class BaseMapFillMaterialValues {
  const new _({required this.color});

  final Color color;
}

/// [encodeBaseMapLineMaterialBytes]が詰めた値。
final class BaseMapLineMaterialValues {
  const new _({
    required this.color,
    required this.halfWidthNdcX,
    required this.halfWidthNdcY,
  });

  final Color color;
  final double halfWidthNdcX;
  final double halfWidthNdcY;
}

/// Flutter Scene adapterがuniform blockからFill materialの値を読み戻す。
///
/// byte長が合わない場合は`ArgumentError`にする。pipeline keyとuniform blockの
/// 対応が崩れたまま`setColor`へ進むと、shaderが読む値が静かにずれるため
/// fail closedにする。
BaseMapFillMaterialValues decodeBaseMapFillMaterialBytes(Uint8List bytes) {
  if (bytes.length != baseMapFillMaterialByteLength) {
    throw ArgumentError.value(
      bytes.length,
      'bytes',
      'must be $baseMapFillMaterialByteLength bytes',
    );
  }
  return BaseMapFillMaterialValues._(
    color: _readColor(ByteData.sublistView(bytes)),
  );
}

/// Flutter Scene adapterがuniform blockからLine materialの値を読み戻す。
BaseMapLineMaterialValues decodeBaseMapLineMaterialBytes(Uint8List bytes) {
  if (bytes.length != baseMapLineMaterialByteLength) {
    throw ArgumentError.value(
      bytes.length,
      'bytes',
      'must be $baseMapLineMaterialByteLength bytes',
    );
  }
  final data = ByteData.sublistView(bytes);
  return BaseMapLineMaterialValues._(
    color: _readColor(data),
    halfWidthNdcX: data.getFloat32(16, Endian.little),
    halfWidthNdcY: data.getFloat32(20, Endian.little),
  );
}

/// [Color]の各成分を0..1のfloat32として書く。
///
/// `Color.r`などのdouble accessorをそのまま使い、8bit整数へ量子化しない。
/// shader側は正規化済みのfloatを受け取るため、途中で丸める理由がない。
void _writeColor(ByteData data, Color color) {
  data
    ..setFloat32(0, color.r, Endian.little)
    ..setFloat32(4, color.g, Endian.little)
    ..setFloat32(8, color.b, Endian.little)
    ..setFloat32(12, color.a, Endian.little);
}

Color _readColor(ByteData data) => Color.from(
  red: data.getFloat32(0, Endian.little),
  green: data.getFloat32(4, Endian.little),
  blue: data.getFloat32(8, Endian.little),
  alpha: data.getFloat32(12, Endian.little),
);
