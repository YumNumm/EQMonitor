// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'error_message_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(errorMessageBuilder)
final errorMessageBuilderProvider = ErrorMessageBuilderProvider._();

final class ErrorMessageBuilderProvider
    extends
        $FunctionalProvider<
          ErrorMessageBuilder,
          ErrorMessageBuilder,
          ErrorMessageBuilder
        >
    with $Provider<ErrorMessageBuilder> {
  ErrorMessageBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'errorMessageBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$errorMessageBuilderHash();

  @$internal
  @override
  $ProviderElement<ErrorMessageBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ErrorMessageBuilder create(Ref ref) {
    return errorMessageBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ErrorMessageBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ErrorMessageBuilder>(value),
    );
  }
}

String _$errorMessageBuilderHash() =>
    r'd2db2b14972a666e3b240b50e48e0dbd2efad33a';
