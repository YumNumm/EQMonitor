// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_links_interaction.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appLinksInteraction)
final appLinksInteractionProvider = AppLinksInteractionProvider._();

final class AppLinksInteractionProvider
    extends $FunctionalProvider<AsyncValue<Uri>, Uri, Stream<Uri>>
    with $FutureModifier<Uri>, $StreamProvider<Uri> {
  AppLinksInteractionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLinksInteractionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLinksInteractionHash();

  @$internal
  @override
  $StreamProviderElement<Uri> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Uri> create(Ref ref) {
    return appLinksInteraction(ref);
  }
}

String _$appLinksInteractionHash() =>
    r'bc062fb94fc28bc0edcdf11eba16264db0ee91cc';
