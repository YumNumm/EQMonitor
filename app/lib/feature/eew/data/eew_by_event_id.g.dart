// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_by_event_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewsByEventId)
final eewsByEventIdProvider = EewsByEventIdFamily._();

final class EewsByEventIdProvider
    extends $AsyncNotifierProvider<EewsByEventId, List<EewTelegramItem>> {
  EewsByEventIdProvider._({
    required EewsByEventIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eewsByEventIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eewsByEventIdHash();

  @override
  String toString() {
    return r'eewsByEventIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EewsByEventId create() => EewsByEventId();

  @override
  bool operator ==(Object other) {
    return other is EewsByEventIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eewsByEventIdHash() => r'f53a7d1546efb63b9acc638c695433bb09032f33';

final class EewsByEventIdFamily extends $Family
    with
        $ClassFamilyOverride<
          EewsByEventId,
          AsyncValue<List<EewTelegramItem>>,
          List<EewTelegramItem>,
          FutureOr<List<EewTelegramItem>>,
          String
        > {
  EewsByEventIdFamily._()
    : super(
        retry: null,
        name: r'eewsByEventIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EewsByEventIdProvider call(String eventId) =>
      EewsByEventIdProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eewsByEventIdProvider';
}

abstract class _$EewsByEventId extends $AsyncNotifier<List<EewTelegramItem>> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  FutureOr<List<EewTelegramItem>> build(String eventId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<EewTelegramItem>>, List<EewTelegramItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EewTelegramItem>>,
                List<EewTelegramItem>
              >,
              AsyncValue<List<EewTelegramItem>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
