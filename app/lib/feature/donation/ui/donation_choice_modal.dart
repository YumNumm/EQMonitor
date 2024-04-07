import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/donation/data/donation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class DonationChoiceModal extends HookConsumerWidget {
  const DonationChoiceModal._({
    required this.choices,
  });
  final List<StoreProduct> choices;

  static Future<StoreProduct?> show(
    BuildContext context,
    List<StoreProduct> products,
  ) =>
      showModalBottomSheet<StoreProduct>(
        clipBehavior: Clip.antiAlias,
        context: context,
        builder: (context) => DonationChoiceModal._(choices: products),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedChoices = useMemoized(
      () => choices.sorted((a, b) => a.price.compareTo(b.price)).map((choice) {
        final matchedProduct = Products.values.firstWhereOrNull(
          (product) => product.id == choice.identifier,
        );
        return (choice, matchedProduct);
      }).whereType<(StoreProduct, Products)>(),
      [choices],
    );
    final theme = Theme.of(context);
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onBackground,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: sheetBar),
          const ListTile(
            title: Text('Buy me a ...'),
            visualDensity: VisualDensity.compact,
          ),
          for (final e in sortedChoices)
            () {
              final choice = e.$1;
              final product = e.$2;
              final emoji = product.emoji;
              return ListTile(
                title: Text(product.productName),
                subtitle: Text(choice.description),
                trailing: Text(
                  choice.priceString,
                  style: theme.textTheme.titleSmall,
                ),
                leading: Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                onTap: () => Navigator.of(context).pop(choice),
              );
            }(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Spacer(),
                TextButton(
                  child: const Text('キャンセル'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension ProductEx on Products {
  String get emoji {
    switch (this) {
      case Products.coffee:
        return '☕️';
      case Products.enegyDrink:
        return '🥤';
      case Products.meat:
        return '🍖';
      case Products.eel:
        return '🍱';
    }
  }

  String get productName => switch (this) {
        Products.coffee => 'コーヒー',
        Products.enegyDrink => 'エナジードリンクセット',
        Products.meat => '美味しい牛肉',
        Products.eel => 'うな重'
      };
}
