// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_list_by_event_id_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TelegramListByEventId)
const telegramListByEventIdProvider = TelegramListByEventIdFamily._();

final class TelegramListByEventIdProvider
    extends
        $AsyncNotifierProvider<
          TelegramListByEventId,
          TelegramListByEventIdState
        > {
  const TelegramListByEventIdProvider._({
    required TelegramListByEventIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'telegramListByEventIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$telegramListByEventIdHash();

  @override
  String toString() {
    return r'telegramListByEventIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TelegramListByEventId create() => TelegramListByEventId();

  @override
  bool operator ==(Object other) {
    return other is TelegramListByEventIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$telegramListByEventIdHash() =>
    r'2100e6ac5c6712af24b0b85fb61189559de8b827';

final class TelegramListByEventIdFamily extends $Family
    with
        $ClassFamilyOverride<
          TelegramListByEventId,
          AsyncValue<TelegramListByEventIdState>,
          TelegramListByEventIdState,
          FutureOr<TelegramListByEventIdState>,
          String
        > {
  const TelegramListByEventIdFamily._()
    : super(
        retry: null,
        name: r'telegramListByEventIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TelegramListByEventIdProvider call(String eventId) =>
      TelegramListByEventIdProvider._(argument: eventId, from: this);

  @override
  String toString() => r'telegramListByEventIdProvider';
}

abstract class _$TelegramListByEventId
    extends $AsyncNotifier<TelegramListByEventIdState> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  FutureOr<TelegramListByEventIdState> build(String eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<TelegramListByEventIdState>,
              TelegramListByEventIdState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TelegramListByEventIdState>,
                TelegramListByEventIdState
              >,
              AsyncValue<TelegramListByEventIdState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
