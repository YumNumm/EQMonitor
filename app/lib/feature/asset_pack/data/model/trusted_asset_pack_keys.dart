const assetPackSigningKeyId20260816 = 'asset-pack-2026-08-16';

/// Ed25519 raw public keys trusted for the signed R2 distribution manifest.
///
/// Keep old public keys while any manifest signed by them can still be served.
/// Private keys are held only by the backend release workflow.
const trustedAssetPackPublicKeys = <String, List<int>>{
  assetPackSigningKeyId20260816: [
    0xfb,
    0x90,
    0xad,
    0x54,
    0x05,
    0xf5,
    0xe7,
    0x9d,
    0xeb,
    0x17,
    0xe6,
    0x92,
    0xa0,
    0x60,
    0x0a,
    0xe9,
    0x37,
    0x37,
    0x14,
    0x95,
    0x4e,
    0xb8,
    0xb5,
    0xd2,
    0x16,
    0x16,
    0xb7,
    0xeb,
    0x20,
    0xe2,
    0x45,
    0xa6,
  ],
};
