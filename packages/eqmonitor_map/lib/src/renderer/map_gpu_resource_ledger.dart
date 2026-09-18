import 'dart:collection';

/// GPU resource を identity key で追跡する、Scene 非依存の bookkeeping 台帳。
///
/// この型が `flutter_scene` や `dart:ui` を一切 import しないのは、
/// 「どの resource をいつ手放すか」の判断が GPU API と無関係な純粋な帳簿処理であり、
/// headless な unit test で全分岐を検証したいから。`renderer/` 配下は Scene 型を
/// 持ち込まない方針（計画書「`renderer/` は `flutter_scene` を import しない」）に従う。
///
/// ## "retire" の意味（誇張しない）
///
/// ここでいう retire は **Dart 側の参照を落として GC 対象にすること**と、
/// 以後その key での再利用を禁止する（fail closed）ことだけを指す。
/// **決定的な GPU メモリ解放は約束しない。** `flutter_scene` の `gpu.DeviceBuffer` は
/// `NativeFieldWrapperClass1` を継承するだけで `dispose()`/`destroy()` を持たず、
/// 実際に VRAM が返る時期は GC 依存で観測できない
/// （`docs/todo/820_flutter_scene_batched_instance_slot_clobber.md`、
/// `docs/superpowers/plans/2026-08-15-flutter-scene-static-instance-geometry.md`
/// に同じ注意書きがある）。
///
/// したがって frames-in-flight の追跡は「メモリが早く返る」ための仕組みではない。
/// **まだ GPU に投入済み（in-flight）な frame が掴んでいる可能性のある参照を、
/// こちらから先に落とさない**ための下限保証にすぎない。
///
/// ## key の同一性
///
/// key は `==` ではなく `identical` で比較する。呼び出し側は `MapPackedMesh` の
/// instance identity を GPU resource の key にする設計（計画書「GPU resource の
/// identity」）であり、value 等価な別 instance を同じ resource と誤認すると
/// 古い buffer を新しい mesh の bytes として描いてしまうため。
///
/// ## 使い方
///
/// frame ごとに [beginFrame] を呼び、[lookup] が null を返した key にだけ
/// GPU resource を作って [put] する。frame 末尾で [retireIdle]、破棄時に [retireAll]。
final class MapGpuResourceLedger<R extends Object> {
  /// [maxFramesInFlight] は「GPU へ投入済みで完了未確認の frame 数の上限」。
  /// 上限値はこの型で決め打ちしない（呼び出し側が実行環境に応じて渡す）。
  new({required int maxFramesInFlight})
    : _maxFramesInFlight = maxFramesInFlight {
    if (maxFramesInFlight < 1) {
      throw ArgumentError.value(
        maxFramesInFlight,
        'maxFramesInFlight',
        'must be at least 1',
      );
    }
  }

  final int _maxFramesInFlight;

  /// insertion order には意味を持たせない（retire 順は呼び出し側が依存してよい
  /// 契約ではない）ため、identity 比較の [HashMap] をそのまま使う。
  final _entries = HashMap<Object, _MapGpuResourceEntry<R>>(
    equals: identical,
    hashCode: identityHashCode,
  );

  var _contextGeneration = 0;

  /// null は「まだ [beginFrame] を一度も通っていない」ことを表す。
  /// frame 番号が確定していない状態で resource を登録すると idle 判定の基準が
  /// 無いまま台帳が育つので、その状態は [StateError] で弾く。
  int? _currentFrame;

  /// 最後に [beginFrame] へ渡された Scene context の世代。初回 [beginFrame] 前は 0。
  int get contextGeneration => _contextGeneration;

  /// まだ retire していない resource 数。test と診断のための観測点。
  int get liveResourceCount => _entries.length;

  /// frame の開始を宣言する。
  ///
  /// [contextGeneration] が前回と変わっていれば、**保持している全 resource** を
  /// retire して返す。世代をまたいだ再利用を許すと、破棄済み context 由来の handle を
  /// 新しい context で bind しかねないため、部分的な引き継ぎは一切しない（fail closed）。
  ///
  /// [frameNumber] は非減少でなければならない。減少を許すと idle 判定が
  /// 「未使用が続いた長さ」を測れなくなり、in-flight な frame の参照を落としうる。
  /// 同値は許す（1 frame が複数回 submit することがある）。
  List<R> beginFrame({
    required int contextGeneration,
    required int frameNumber,
  }) {
    if (contextGeneration < 0) {
      throw ArgumentError.value(
        contextGeneration,
        'contextGeneration',
        'must not be negative',
      );
    }
    if (frameNumber < 0) {
      throw ArgumentError.value(
        frameNumber,
        'frameNumber',
        'must not be negative',
      );
    }
    final previousFrame = _currentFrame;
    if (previousFrame != null && frameNumber < previousFrame) {
      throw ArgumentError.value(
        frameNumber,
        'frameNumber',
        'must not decrease (previous frame was $previousFrame)',
      );
    }

    _currentFrame = frameNumber;
    if (contextGeneration == _contextGeneration) {
      return <R>[];
    }
    _contextGeneration = contextGeneration;
    return _drain();
  }

  /// [key] に紐づく resource を返す。hit した場合は「この frame で使った」と記録し、
  /// [retireIdle] の猶予を延ばす。miss は null（呼び出し側が作って [put] する）。
  R? lookup({required Object key}) {
    final currentFrame = _requireCurrentFrame();
    final entry = _entries[key];
    if (entry == null) {
      return null;
    }
    entry.lastUsedFrame = currentFrame;
    return entry.resource;
  }

  /// [key] に resource を登録する。
  ///
  /// 既に生きている key への [put] は [StateError]。上書きを許すと前の resource への
  /// 参照が retire 経路を通らず黙って消え、in-flight な frame の分を追跡できなくなる。
  /// 呼び出し側は必ず [lookup] が null であることを確認してから呼ぶ。
  void put({required Object key, required R resource}) {
    final currentFrame = _requireCurrentFrame();
    if (_entries.containsKey(key)) {
      throw StateError(
        'A GPU resource is already registered for this key; '
        'lookup() must miss before put().',
      );
    }
    _entries[key] = _MapGpuResourceEntry<R>(
      resource: resource,
      lastUsedFrame: currentFrame,
    );
  }

  /// `maxFramesInFlight` より長く未使用の resource を retire して返す。
  ///
  /// 判定は `lastUsedFrame < currentFrame - maxFramesInFlight`。現 frame で
  /// 使われた entry は決して retire されない。
  List<R> retireIdle() {
    final currentFrame = _requireCurrentFrame();
    final deadline = currentFrame - _maxFramesInFlight;
    final retired = <R>[];
    _entries.removeWhere((_, entry) {
      if (entry.lastUsedFrame < deadline) {
        retired.add(entry.resource);
        return true;
      }
      return false;
    });
    return retired;
  }

  /// 全 resource を retire して返す（dispose / context 喪失の経路）。
  ///
  /// 冪等であり、2 回目以降は空を返す。retire 後も台帳は生きているので、
  /// 次の [beginFrame] からそのまま再登録できる。
  List<R> retireAll() => _drain();

  List<R> _drain() {
    final retired = <R>[];
    for (final entry in _entries.values) {
      retired.add(entry.resource);
    }
    _entries.clear();
    return retired;
  }

  int _requireCurrentFrame() {
    final currentFrame = _currentFrame;
    if (currentFrame == null) {
      throw StateError(
        'beginFrame() must be called before using the GPU resource ledger.',
      );
    }
    return currentFrame;
  }
}

final class _MapGpuResourceEntry<R extends Object> {
  new({required this.resource, required this.lastUsedFrame});

  final R resource;

  /// 最後に [MapGpuResourceLedger.lookup] が hit した frame 番号。
  int lastUsedFrame;
}
