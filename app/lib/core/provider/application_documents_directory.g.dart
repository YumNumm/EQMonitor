// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'application_documents_directory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(applicationDocumentsDirectory)
const applicationDocumentsDirectoryProvider =
    ApplicationDocumentsDirectoryProvider._();

final class ApplicationDocumentsDirectoryProvider
    extends $FunctionalProvider<Directory, Directory>
    with $Provider<Directory> {
  const ApplicationDocumentsDirectoryProvider._()
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
      providerOverride: $ValueProvider<Directory>(value),
    );
  }
}

String _$applicationDocumentsDirectoryHash() =>
    r'246c835294da120f3536b1486d6fcaedde798440';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
