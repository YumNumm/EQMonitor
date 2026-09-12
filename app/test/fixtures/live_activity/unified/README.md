# Unified Live Activity fixtures

`canonical.json` is copied unchanged from
`docs/examples/unified-live-activity-content-state.json` at backend commit
`00f2caf9ffef0861f0b9a52cca675593d9c60409`.

`matrix.json` is the shared Swift and Dart contract matrix. Each entry contains
static `attributes`, a complete `contentState`, and the expected `valid` result.

`sha256.json` uses the canonical state with a 64-character hexadecimal test ID.
It verifies that the logical ID is opaque and is not restricted to UUID syntax;
it is a test fixture, not a backend-issued event identifier.
