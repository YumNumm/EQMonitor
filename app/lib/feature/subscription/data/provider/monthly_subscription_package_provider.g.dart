// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'monthly_subscription_package_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(monthlySubscriptionPackage)
final monthlySubscriptionPackageProvider =
    MonthlySubscriptionPackageProvider._();

final class MonthlySubscriptionPackageProvider
    extends
        $FunctionalProvider<
          AsyncValue<rc.Package?>,
          rc.Package?,
          FutureOr<rc.Package?>
        >
    with $FutureModifier<rc.Package?>, $FutureProvider<rc.Package?> {
  MonthlySubscriptionPackageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthlySubscriptionPackageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthlySubscriptionPackageHash();

  @$internal
  @override
  $FutureProviderElement<rc.Package?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<rc.Package?> create(Ref ref) {
    return monthlySubscriptionPackage(ref);
  }
}

String _$monthlySubscriptionPackageHash() =>
    r'bd8af2b6b57dad2bb89af5756d8bf5643b657758';
