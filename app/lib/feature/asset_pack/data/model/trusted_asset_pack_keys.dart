const assetPackSigningKeyId20260816 = 'asset-pack-2026-08-16';

/// Ed25519 raw public keys trusted for the signed R2 distribution manifest.
///
/// Keep old public keys while any manifest signed by them can still be served.
/// Private keys are held only by the backend release workflow.
const trustedAssetPackPublicKeys = <String, List<int>>{
  assetPackSigningKeyId20260816: [
    0x93,
    0xd9,
    0xa6,
    0x49,
    0x8f,
    0x19,
    0x4b,
    0x47,
    0xe4,
    0x76,
    0xa5,
    0x98,
    0xde,
    0x81,
    0x50,
    0xdb,
    0x24,
    0x40,
    0xbe,
    0x9e,
    0x14,
    0x0e,
    0xaa,
    0xa7,
    0x71,
    0x50,
    0x1d,
    0x60,
    0xff,
    0xfa,
    0x26,
    0x61,
  ],
};
