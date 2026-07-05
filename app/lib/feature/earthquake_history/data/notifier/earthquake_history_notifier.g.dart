// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeHistoryNotifier)
final earthquakeHistoryProvider = EarthquakeHistoryNotifierFamily._();

final class EarthquakeHistoryNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeHistoryNotifier,
          PaginatedResponse<EarthquakePartial>
        > {
  EarthquakeHistoryNotifierProvider._({
    required EarthquakeHistoryNotifierFamily super.from,
    required EarthquakeHistoryParameter super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryNotifierHash();

  @override
  String toString() {
    return r'earthquakeHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeHistoryNotifier create() => EarthquakeHistoryNotifier();

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeHistoryNotifierHash() =>
    r'f9426157417ff59129e52d7b8119351657282d7f';

final class EarthquakeHistoryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeHistoryNotifier,
          AsyncValue<PaginatedResponse<EarthquakePartial>>,
          PaginatedResponse<EarthquakePartial>,
          FutureOr<PaginatedResponse<EarthquakePartial>>,
          EarthquakeHistoryParameter
        > {
  EarthquakeHistoryNotifierFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryNotifierProvider call(
    EarthquakeHistoryParameter parameter,
  ) => EarthquakeHistoryNotifierProvider._(argument: parameter, from: this);

  @override
  String toString() => r'earthquakeHistoryProvider';
}

abstract class _$EarthquakeHistoryNotifier
    extends $AsyncNotifier<PaginatedResponse<EarthquakePartial>> {
  late final _$args = ref.$arg as EarthquakeHistoryParameter;
  EarthquakeHistoryParameter get parameter => _$args;

  FutureOr<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  );
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PaginatedResponse<EarthquakePartial>>,
              PaginatedResponse<EarthquakePartial>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedResponse<EarthquakePartial>>,
                PaginatedResponse<EarthquakePartial>
              >,
              AsyncValue<PaginatedResponse<EarthquakePartial>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
