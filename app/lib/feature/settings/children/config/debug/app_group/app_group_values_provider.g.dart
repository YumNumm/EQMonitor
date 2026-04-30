// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_group_values_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appGroupValues)
final appGroupValuesProvider = AppGroupValuesProvider._();

final class AppGroupValuesProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppGroupValues>,
          AppGroupValues,
          FutureOr<AppGroupValues>
        >
    with $FutureModifier<AppGroupValues>, $FutureProvider<AppGroupValues> {
  AppGroupValuesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appGroupValuesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appGroupValuesHash();

  @$internal
  @override
  $FutureProviderElement<AppGroupValues> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppGroupValues> create(Ref ref) {
    return appGroupValues(ref);
  }
}

String _$appGroupValuesHash() => r'00f1bc19b5321ad04914c68e668e076732f9cb34';
