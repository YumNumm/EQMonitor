// app lifecycleがGPU resourceの寿命と描画の可否をどう決めるかのpolicy。
//
// widgetのcontroller内にif文として散らすとGPUなしのunit testで検証できない
// ため、遷移表だけをpure関数として切り出している(#1593完了条件
// 「lifecycle unit/fake test」)。Flutter Sceneの型には依存しない。

import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';

/// FlutterのapplifecycleをMapのlifecycleへ写す。
///
/// `null`(まだ一度も通知が来ていない起動直後)は[MapAppLifecycle.active]と
/// 扱う。起動直後に描画を止めると初回frameが出ないためであり、
/// `AppLifecycleState.resumed`と同じ扱いで問題ない。
///
/// `hidden`と`paused`を同じ[MapAppLifecycle.background]へ写すのは、
/// AndroidでどちらもsurfaceがGPU contextを失い得る状態だからである。
/// `inactive`(通知シェードを引いた、通話が来た等)はsurfaceが生きており
/// GPU resourceを捨てる理由がないため[MapAppLifecycle.inactive]のままにする。
MapAppLifecycle mapAppLifecycleFor(AppLifecycleState? state) => switch (state) {
  null || AppLifecycleState.resumed => MapAppLifecycle.active,
  AppLifecycleState.inactive => MapAppLifecycle.inactive,
  AppLifecycleState.hidden ||
  AppLifecycleState.paused => MapAppLifecycle.background,
  AppLifecycleState.detached => MapAppLifecycle.detached,
};

/// この状態でtile要求・decode・GPU uploadを止めるか。
///
/// 設計正本「detach/backgroundではanimation、request、decode、uploadを停止し、
/// resume後は新しいcaptureでfreshness/expiryを再評価してから描画する」。
bool suspendsMapRendering(MapAppLifecycle lifecycle) => switch (lifecycle) {
  MapAppLifecycle.background || MapAppLifecycle.detached => true,
  MapAppLifecycle.active || MapAppLifecycle.inactive => false,
};

/// [to]へ移る時点でGPU resourceを手放すか。
bool retiresGpuResourcesOnTransition({
  required MapAppLifecycle from,
  required MapAppLifecycle to,
}) => from != to && suspendsMapRendering(to);

/// [to]へ移る時点でGPU contextの世代を進めるか。
///
/// backgroundやdetachedからの復帰は、Androidがsurfaceを破棄した可能性を
/// 排除できない。復帰を毎回「context lostの可能性がある」と保守的に扱い、
/// 世代を進めて前世代のGPU resourceを再利用させない(#1593要件3)。
/// `inactive`との往復は世代を進めない — surfaceは生きており、そこで
/// 作り直すと通知シェードを引くたびに全tileを再uploadしてしまう。
bool advancesGpuContextGenerationOnTransition({
  required MapAppLifecycle from,
  required MapAppLifecycle to,
}) => from != to && suspendsMapRendering(from) && !suspendsMapRendering(to);
