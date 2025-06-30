// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eew_by_event_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EewsByEventId)
const eewsByEventIdProvider = EewsByEventIdFamily._();

final class EewsByEventIdProvider
    extends $AsyncNotifierProvider<EewsByEventId, List<EewV1>> {
  const EewsByEventIdProvider._({
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

  @$internal
  @override
  $AsyncNotifierProviderElement<EewsByEventId, List<EewV1>> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(pointer);

  @override
  bool operator ==(Object other) {
    return other is EewsByEventIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eewsByEventIdHash() => r'cd83c02b16e6fd89ac1f52581f12210d0d41f2d3';

final class EewsByEventIdFamily extends $Family
    with
        $ClassFamilyOverride<
          EewsByEventId,
          AsyncValue<List<EewV1>>,
          List<EewV1>,
          FutureOr<List<EewV1>>,
          String
        > {
  const EewsByEventIdFamily._()
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

abstract class _$EewsByEventId extends $AsyncNotifier<List<EewV1>> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  FutureOr<List<EewV1>> build(String eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<EewV1>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<EewV1>>>,
              AsyncValue<List<EewV1>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
