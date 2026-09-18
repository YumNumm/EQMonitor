import 'package:flutter/foundation.dart';

@immutable
final class const HypocenterAnalysisProgress({
  required final int completedArchives,
  required final int totalArchives,
  required final int fetchedEvents,
}) {
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
