// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'apns_token_callback_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apnsTokenCallbackDataSource)
final apnsTokenCallbackDataSourceProvider =
    ApnsTokenCallbackDataSourceProvider._();

final class ApnsTokenCallbackDataSourceProvider
    extends
        $FunctionalProvider<
          ApnsTokenCallbackDataSource,
          ApnsTokenCallbackDataSource,
          ApnsTokenCallbackDataSource
        >
    with $Provider<ApnsTokenCallbackDataSource> {
  ApnsTokenCallbackDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apnsTokenCallbackDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apnsTokenCallbackDataSourceHash();

  @$internal
  @override
  $ProviderElement<ApnsTokenCallbackDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ApnsTokenCallbackDataSource create(Ref ref) {
    return apnsTokenCallbackDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApnsTokenCallbackDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApnsTokenCallbackDataSource>(value),
    );
  }
}

String _$apnsTokenCallbackDataSourceHash() =>
    r'e5d97d5cfae46743136ddb582ef0f135d4e287eb';
