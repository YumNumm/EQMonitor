// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'knet_directory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// all/zip/ 配下の利用可能な年一覧（昇順）

@ProviderFor(knetYears)
final knetYearsProvider = KnetYearsProvider._();

/// all/zip/ 配下の利用可能な年一覧（昇順）

final class KnetYearsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  /// all/zip/ 配下の利用可能な年一覧（昇順）
  KnetYearsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'knetYearsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$knetYearsHash();

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    return knetYears(ref);
  }
}

String _$knetYearsHash() => r'f98419aaa71b1dc6140cb923a5ff49e32122bab5';

/// all/zip/{year}/ 配下の月一覧（昇順）

@ProviderFor(knetMonths)
final knetMonthsProvider = KnetMonthsFamily._();

/// all/zip/{year}/ 配下の月一覧（昇順）

final class KnetMonthsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  /// all/zip/{year}/ 配下の月一覧（昇順）
  KnetMonthsProvider._({
    required KnetMonthsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'knetMonthsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$knetMonthsHash();

  @override
  String toString() {
    return r'knetMonthsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    final argument = this.argument as int;
    return knetMonths(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is KnetMonthsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$knetMonthsHash() => r'f70521ad495e8e4b0ff63b417a1b216834452fe8';

/// all/zip/{year}/ 配下の月一覧（昇順）

final class KnetMonthsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<int>>, int> {
  KnetMonthsFamily._()
    : super(
        retry: null,
        name: r'knetMonthsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// all/zip/{year}/ 配下の月一覧（昇順）

  KnetMonthsProvider call(int year) =>
      KnetMonthsProvider._(argument: year, from: this);

  @override
  String toString() => r'knetMonthsProvider';
}

/// all/zip/{year}/{month}/ 配下の地震記録時刻一覧（降順: 新しい順）

@ProviderFor(knetRecords)
final knetRecordsProvider = KnetRecordsFamily._();

/// all/zip/{year}/{month}/ 配下の地震記録時刻一覧（降順: 新しい順）

final class KnetRecordsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DateTime>>,
          List<DateTime>,
          FutureOr<List<DateTime>>
        >
    with $FutureModifier<List<DateTime>>, $FutureProvider<List<DateTime>> {
  /// all/zip/{year}/{month}/ 配下の地震記録時刻一覧（降順: 新しい順）
  KnetRecordsProvider._({
    required KnetRecordsFamily super.from,
    required (int, int) super.argument,
  }) : super(
         retry: null,
         name: r'knetRecordsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$knetRecordsHash();

  @override
  String toString() {
    return r'knetRecordsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<DateTime>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DateTime>> create(Ref ref) {
    final argument = this.argument as (int, int);
    return knetRecords(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is KnetRecordsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$knetRecordsHash() => r'df04459a5843ad72d8710e49a991758a28f94c5f';

/// all/zip/{year}/{month}/ 配下の地震記録時刻一覧（降順: 新しい順）

final class KnetRecordsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<DateTime>>, (int, int)> {
  KnetRecordsFamily._()
    : super(
        retry: null,
        name: r'knetRecordsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// all/zip/{year}/{month}/ 配下の地震記録時刻一覧（降順: 新しい順）

  KnetRecordsProvider call(int year, int month) =>
      KnetRecordsProvider._(argument: (year, month), from: this);

  @override
  String toString() => r'knetRecordsProvider';
}
