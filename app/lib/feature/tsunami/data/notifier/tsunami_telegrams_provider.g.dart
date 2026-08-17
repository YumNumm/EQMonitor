// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegrams_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tsunamiTelegrams)
final tsunamiTelegramsProvider = TsunamiTelegramsFamily._();

final class TsunamiTelegramsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TsunamiTelegramWithState>>,
          List<TsunamiTelegramWithState>,
          FutureOr<List<TsunamiTelegramWithState>>
        >
    with
        $FutureModifier<List<TsunamiTelegramWithState>>,
        $FutureProvider<List<TsunamiTelegramWithState>> {
  TsunamiTelegramsProvider._({
    required TsunamiTelegramsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tsunamiTelegramsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tsunamiTelegramsHash();

  @override
  String toString() {
    return r'tsunamiTelegramsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TsunamiTelegramWithState>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TsunamiTelegramWithState>> create(Ref ref) {
    final argument = this.argument as String;
    return tsunamiTelegrams(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TsunamiTelegramsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tsunamiTelegramsHash() => r'fe2fc9f7edcd994d05c900a11429fb3c87f099e9';

final class TsunamiTelegramsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<TsunamiTelegramWithState>>,
          String
        > {
  TsunamiTelegramsFamily._()
    : super(
        retry: null,
        name: r'tsunamiTelegramsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TsunamiTelegramsProvider call(String tsunamiId) =>
      TsunamiTelegramsProvider._(argument: tsunamiId, from: this);

  @override
  String toString() => r'tsunamiTelegramsProvider';
}
