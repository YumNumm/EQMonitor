import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';

final class const MapRevisionCandidate<TState>({
  required final TState state,
  required final MapContentDigest digest,
});

abstract interface class MapRevisionStateOwner<TState> {
  MapRevisionCandidate<TState> own({
    required MapRevisionCandidate<TState> candidate,
  });
}
