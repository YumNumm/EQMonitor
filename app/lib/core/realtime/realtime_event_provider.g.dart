// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 全データソースを集約し、正規化された [RealtimeEvent] を emit するプロバイダー。
///
/// 現在は EqMonitor WebSocket のみ。将来的に DMDATA 等を追加する場合は
/// ここに `ref.listen` を追加し、重複排除ロジックを実装する。

@ProviderFor(RealtimeEvents)
final realtimeEventsProvider = RealtimeEventsProvider._();

/// 全データソースを集約し、正規化された [RealtimeEvent] を emit するプロバイダー。
///
/// 現在は EqMonitor WebSocket のみ。将来的に DMDATA 等を追加する場合は
/// ここに `ref.listen` を追加し、重複排除ロジックを実装する。
final class RealtimeEventsProvider
    extends $StreamNotifierProvider<RealtimeEvents, RealtimeEvent> {
  /// 全データソースを集約し、正規化された [RealtimeEvent] を emit するプロバイダー。
  ///
  /// 現在は EqMonitor WebSocket のみ。将来的に DMDATA 等を追加する場合は
  /// ここに `ref.listen` を追加し、重複排除ロジックを実装する。
  RealtimeEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'realtimeEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$realtimeEventsHash();

  @$internal
  @override
  RealtimeEvents create() => RealtimeEvents();
}

String _$realtimeEventsHash() => r'08106708095c270c98c1e204f44024f45c638b04';

/// 全データソースを集約し、正規化された [RealtimeEvent] を emit するプロバイダー。
///
/// 現在は EqMonitor WebSocket のみ。将来的に DMDATA 等を追加する場合は
/// ここに `ref.listen` を追加し、重複排除ロジックを実装する。

abstract class _$RealtimeEvents extends $StreamNotifier<RealtimeEvent> {
  Stream<RealtimeEvent> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RealtimeEvent>, RealtimeEvent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RealtimeEvent>, RealtimeEvent>,
              AsyncValue<RealtimeEvent>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
