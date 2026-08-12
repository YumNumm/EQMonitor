// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_history_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tsunamiHistoryDataSource)
final tsunamiHistoryDataSourceProvider = TsunamiHistoryDataSourceProvider._();

final class TsunamiHistoryDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<TsunamiHistoryDataSource>,
          TsunamiHistoryDataSource,
          FutureOr<TsunamiHistoryDataSource>
        >
    with
        $FutureModifier<TsunamiHistoryDataSource>,
        $FutureProvider<TsunamiHistoryDataSource> {
  TsunamiHistoryDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tsunamiHistoryDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tsunamiHistoryDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<TsunamiHistoryDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TsunamiHistoryDataSource> create(Ref ref) {
    return tsunamiHistoryDataSource(ref);
  }
}

String _$tsunamiHistoryDataSourceHash() =>
    r'059e3ad176cdbf048a45179aa1c3163686bf2902';
