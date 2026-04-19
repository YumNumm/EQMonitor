// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'application_documents_directory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(applicationDocumentsDirectory)
final applicationDocumentsDirectoryProvider =
    ApplicationDocumentsDirectoryProvider._();

final class ApplicationDocumentsDirectoryProvider
    extends $FunctionalProvider<Directory, Directory, Directory>
    with $Provider<Directory> {
  ApplicationDocumentsDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationDocumentsDirectoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationDocumentsDirectoryHash();

  @$internal
  @override
  $ProviderElement<Directory> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Directory create(Ref ref) {
    return applicationDocumentsDirectory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Directory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Directory>(value),
    );
  }
}

String _$applicationDocumentsDirectoryHash() =>
    r'246c835294da120f3536b1486d6fcaedde798440';
