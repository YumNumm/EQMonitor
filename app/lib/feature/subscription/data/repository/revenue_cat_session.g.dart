// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'revenue_cat_session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(revenueCatSession)
final revenueCatSessionProvider = RevenueCatSessionProvider._();

final class RevenueCatSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<RevenueCatSession>,
          RevenueCatSession,
          FutureOr<RevenueCatSession>
        >
    with
        $FutureModifier<RevenueCatSession>,
        $FutureProvider<RevenueCatSession> {
  RevenueCatSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'revenueCatSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$revenueCatSessionHash();

  @$internal
  @override
  $FutureProviderElement<RevenueCatSession> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RevenueCatSession> create(Ref ref) {
    return revenueCatSession(ref);
  }
}

String _$revenueCatSessionHash() => r'3063658b6714766346110dfa5dad21bddf2477b7';
