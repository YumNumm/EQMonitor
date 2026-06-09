#!/bin/bash
# Workaround for purchases-ios-spm Xcode 26+ compatibility.
# Moves the designated init into the struct body to suppress the
# synthesized memberwise init conflicting with init(stringRepresentation:) throws.
# See: https://github.com/RevenueCat/purchases-ios/pull/6949
# TODO: Remove when purchases-hybrid-common pins purchases-ios-spm >= 5.78.0

set -euo pipefail

FILE="${1:-}"
[ -z "$FILE" ] && exit 0
[ ! -f "$FILE" ] && exit 0

# Already patched or fixed version: init exists in struct body (first ~60 lines)
if head -60 "$FILE" | grep -q 'private init(stringRepresentation: String, underlyingColor:'; then
    exit 0
fi

echo "note: Patching PaywallColor.swift for Xcode 26+ compatibility (RevenueCat/purchases-ios#6949)"

awk '
/fileprivate var _underlyingColor: \(any Sendable\)\?$/ {
    print
    getline
    print
    print "    /// \"Designated\" initializer"
    print "    private init(stringRepresentation: String, underlyingColor: (any Sendable)?) {"
    print "        self.stringRepresentation = stringRepresentation"
    print "        self._underlyingColor = underlyingColor"
    print "    }"
    print ""
    next
}
/^    \/\/\/ "Designated" initializer$/ {
    getline; getline; getline; getline; getline
    next
}
{ print }
' "$FILE" > "${FILE}.patched" && mv "${FILE}.patched" "$FILE"
