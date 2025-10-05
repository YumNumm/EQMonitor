// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_summary.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tsunamiSummary)
const tsunamiSummaryProvider = TsunamiSummaryProvider._();

final class TsunamiSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TsunamiEvent>>,
          List<TsunamiEvent>,
          FutureOr<List<TsunamiEvent>>
        >
    with
        $FutureModifier<List<TsunamiEvent>>,
        $FutureProvider<List<TsunamiEvent>> {
  const TsunamiSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tsunamiSummaryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tsunamiSummaryHash();

  @$internal
  @override
  $FutureProviderElement<List<TsunamiEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TsunamiEvent>> create(Ref ref) {
    return tsunamiSummary(ref);
  }
}

String _$tsunamiSummaryHash() => r'd9c2cc73079a6213ec858e02a9d0a1da676a4742';
