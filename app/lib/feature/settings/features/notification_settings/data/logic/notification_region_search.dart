import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

part 'notification_region_search.g.dart';

@riverpod
NotificationRegionSearch notificationRegionSearch(Ref ref) =>
    const NotificationRegionSearch();

final class NotificationRegionSearch {
  const NotificationRegionSearch();

  List<T> filter<T>({
    required List<T> items,
    required String query,
    required String Function(T item) name,
    required String? Function(T item) kana,
  }) {
    final normalizedQuery = normalize(query);
    if (normalizedQuery.isEmpty) {
      return items;
    }
    return items.where((item) {
      final itemKana = kana(item);
      return normalize(name(item)).contains(normalizedQuery) ||
          (itemKana != null && normalize(itemKana).contains(normalizedQuery));
    }).toList();
  }

  String normalize(String value) {
    final compact = unorm
        .nfkc(value)
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '');
    return String.fromCharCodes(
      compact.runes.map(
        (codePoint) => codePoint >= 0x30A1 && codePoint <= 0x30F6
            ? codePoint - 0x60
            : codePoint,
      ),
    );
  }
}
