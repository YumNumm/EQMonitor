import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';

final class MapRevisionCandidate<TState> {
  const MapRevisionCandidate({required this.state, required this.digest});

  final TState state;
  final MapContentDigest digest;
}

abstract interface class MapRevisionStateOwner<TState> {
  MapRevisionCandidate<TState> own({
    required MapRevisionCandidate<TState> candidate,
  });
}
