class EqmPayload {
  EqmPayload({
    required this.type,
    required this.hash,
    required this.payload,
  });

  final EqmPayloadType type;
  final String hash;
  final dynamic payload;
}

enum EqmPayloadType {
  eew,
  earthquake,
}
