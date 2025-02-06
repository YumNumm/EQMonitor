import 'package:eqmonitor/feature/map/layer/base/i_map_layer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'layer_controller.g.dart';

/// マップのレイヤーを管理するコントローラー
@riverpod
class MapLayerController extends _$MapLayerController {
  @override
  List<IMapLayer> build() {
    return [];
  }

  /// レイヤーを追加
  void addLayer(IMapLayer layer) {
    state = [...state, layer];
  }

  /// レイヤーを削除
  void removeLayer(String id) {
    state = state.where((layer) => layer.id != id).toList();
  }

  /// レイヤーを更新
  void updateLayer(IMapLayer layer) {
    state = state.map((l) => l.id == layer.id ? layer : l).toList();
  }

  /// レイヤーの順序を変更
  void reorderLayers(List<String> orderedIds) {
    final layerMap = {for (final l in state) l.id: l};
    state = orderedIds
        .where(layerMap.containsKey)
        .map((id) => layerMap[id]!)
        .toList();
  }
}
