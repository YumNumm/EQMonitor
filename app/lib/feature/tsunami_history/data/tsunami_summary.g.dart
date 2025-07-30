// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'tsunami_summary.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(tsunamiSummary)
const tsunamiSummaryProvider = TsunamiSummaryProvider._();

final class TsunamiSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<TsunamiSummaryResponse>,
          TsunamiSummaryResponse,
          FutureOr<TsunamiSummaryResponse>
        >
    with
        $FutureModifier<TsunamiSummaryResponse>,
        $FutureProvider<TsunamiSummaryResponse> {
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
  $FutureProviderElement<TsunamiSummaryResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TsunamiSummaryResponse> create(Ref ref) {
    return tsunamiSummary(ref);
  }
}

String _$tsunamiSummaryHash() => r'a32a878487ed764021c080688cfec15c4ef1066a';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
