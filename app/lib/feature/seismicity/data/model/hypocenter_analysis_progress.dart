import 'package:flutter/foundation.dart';

@immutable
final class HypocenterAnalysisProgress {
  const new({
    required this.completedArchives,
    required this.totalArchives,
    required this.fetchedEvents,
  });

  final int completedArchives;
  final int totalArchives;
  final int fetchedEvents;

  @override
  bool operator ==(Object other) =>
      other is HypocenterAnalysisProgress &&
      completedArchives == other.completedArchives &&
      totalArchives == other.totalArchives &&
      fetchedEvents == other.fetchedEvents;

  @override
  int get hashCode => Object.hash(
    completedArchives,
    totalArchives,
    fetchedEvents,
  );
}
