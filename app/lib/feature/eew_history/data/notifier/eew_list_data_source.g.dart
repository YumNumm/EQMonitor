// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_list_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewListDataSource)
final eewListDataSourceProvider = EewListDataSourceFamily._();

final class EewListDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<EewListDataSource>,
          EewListDataSource,
          FutureOr<EewListDataSource>
        >
    with
        $FutureModifier<EewListDataSource>,
        $FutureProvider<EewListDataSource> {
  EewListDataSourceProvider._({
    required EewListDataSourceFamily super.from,
    required EewListParameter super.argument,
  }) : super(
         retry: null,
         name: r'eewListDataSourceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eewListDataSourceHash();

  @override
  String toString() {
    return r'eewListDataSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EewListDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EewListDataSource> create(Ref ref) {
    final argument = this.argument as EewListParameter;
    return eewListDataSource(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EewListDataSourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eewListDataSourceHash() => r'987c9767436a322f1ef51e98e7ac333079232ea6';

final class EewListDataSourceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<EewListDataSource>,
          EewListParameter
        > {
  EewListDataSourceFamily._()
    : super(
        retry: null,
        name: r'eewListDataSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EewListDataSourceProvider call(EewListParameter parameter) =>
      EewListDataSourceProvider._(argument: parameter, from: this);

  @override
  String toString() => r'eewListDataSourceProvider';
}
