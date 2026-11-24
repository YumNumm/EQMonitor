#!/usr/bin/env bash
# simctl に壁紙の設定が無く、写真アプリから設定した壁紙は Simulator で黒く描画される。
# PosterBoard の保存領域（非公開の形式）へ、標準の CollectionsPoster の静止画として直接書き込む。
set -euo pipefail

if [[ $# -ne 2 && $# -ne 4 ]]; then
  echo "usage: $0 <simulator-udid> <image> [<width-px> <height-px>]" >&2
  exit 2
fi
UDID="$1"; IMG="$2"; PXW="${3:-1206}"; PXH="${4:-2622}"
if [[ ! -f "$IMG" ]]; then
  echo "error: $IMG does not exist" >&2
  exit 1
fi
WID=99001
NAME="$WID.Custom.wallpaper"
DATA="$HOME/Library/Developer/CoreSimulator/Devices/$UDID/data"
STORE_ROOT="$DATA/Library/Application Support/PRBPosterExtensionDataStore"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

xcrun simctl bootstatus "$UDID" -b >/dev/null
STORE=""
ready=false
# 新規の Simulator では switcher-index.json ができるまで起動から約 10 分かかった。できる前に書き込むと、選択中と記録されても描画されなかった。
for _ in $(seq 1 600); do
  STORE="$(ls -d "$STORE_ROOT"/*/ 2>/dev/null | head -1 || true)"
  if [ -n "$STORE" ] && [ -s "${STORE}PRPosterRoleLockScreen-switcher-index.json" ] && ls -d "$STORE"Extensions/com.apple.WallpaperKit.CollectionsPoster/descriptors/*/versions/*/contents >/dev/null 2>&1 \
     && [ -n "$(sqlite3 "$STORE/PBFPosterExtensionDataStoreSQLiteDatabase.sqlite3" "select posterUUID from posterAttributes where roleId='PRPosterRoleLockScreen' and attributeIdentifier='SELECTED'" 2>/dev/null)" ]; then
    ready=true
    break
  fi
  sleep 2
done
if [[ "$ready" != true ]]; then
  echo "error: PosterBoard store did not appear under $STORE_ROOT" >&2
  exit 1
fi
for installed in "$STORE"Extensions/com.apple.WallpaperKit.CollectionsPoster/configurations/*/com.apple.posterkit.provider.descriptor.identifier; do
  if [[ -f "$installed" && "$(cat "$installed")" == "$WID" ]]; then
    echo "wallpaper is already installed on $UDID"
    exit 0
  fi
done
sleep 5
xcrun simctl shutdown "$UDID"
sleep 2

STORE="${STORE%/}"
DB="$STORE/PBFPosterExtensionDataStoreSQLiteDatabase.sqlite3"
EXT="$STORE/Extensions"
CP="$EXT/com.apple.WallpaperKit.CollectionsPoster"
CUR="$(sqlite3 "$DB" "select posterUUID from posterAttributes where roleId='PRPosterRoleLockScreen' and attributeIdentifier='SELECTED' limit 1")"
CURPROV="$(sqlite3 "$DB" "select providerId from poster where UUID='$CUR'")"
CURVER="$(ls -d "$EXT/$CURPROV/configurations/$CUR/versions"/* | sort -t/ -k1 -V | tail -1)"
TPL="$(ls -d "$CP"/descriptors/*/ | head -1)"; TPL="${TPL%/}"
TPLVER="$(ls -d "$TPL/versions"/* | sort -V | tail -1)"

SW=$(sips -g pixelWidth "$IMG" | awk '/pixelWidth/{print $2}'); SH=$(sips -g pixelHeight "$IMG" | awk '/pixelHeight/{print $2}')
if [ $((SW * PXH)) -gt $((SH * PXW)) ]; then CH=$SH; CW=$((SH * PXW / PXH)); else CW=$SW; CH=$((SW * PXH / PXW)); fi
sips -c "$CH" "$CW" "$IMG" --out "$TMP/crop.png" -s format png >/dev/null
sips -z "$PXH" "$PXW" -s format heic "$TMP/crop.png" --out "$TMP/full.heic" >/dev/null
sips -z $((PXH / 5)) $((PXW / 5)) -s format heic "$TMP/crop.png" --out "$TMP/thumb.heic" >/dev/null

NEW="$(uuidgen)"
CFG="$CP/configurations/$NEW"
V="$CFG/versions/0"
B="$V/contents/$NAME"
mkdir -p "$B" "$V/supplements/0" "$V/scratch" "$CFG/scratch"
printf 'PRPosterRoleLockScreen' > "$CFG/com.apple.posterkit.role.identifier"
printf '%s' "$WID" > "$CFG/com.apple.posterkit.provider.descriptor.identifier"
cp "$TPL/providerInfo.plist" "$CFG/providerInfo.plist"
for f in com.apple.posterkit.provider.contents.galleryOptions .com.apple.posterkit.provider.contents.configurableOptions.plist; do
  [ -e "$TPLVER/contents/$f" ] && cp "$TPLVER/contents/$f" "$V/contents/$f"
done
cp "$CURVER"/supplements/0/* "$V/supplements/0/" 2>/dev/null || true
cp "$CURVER"/com.apple.posterkit.provider.instance.* "$V/" 2>/dev/null || true
cp "$TMP/full.heic" "$B/custom.heic"; cp "$TMP/thumb.heic" "$B/custom.thumbnail.heic"

cat > "$V/contents/com.apple.posterkit.provider.contents.userInfo" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>wallpaperRepresentingFileName</key><string>$NAME</string>
<key>wallpaperRepresentingIdentifier</key><string>$WID</string>
</dict></plist>
EOF
plutil -convert binary1 "$V/contents/com.apple.posterkit.provider.contents.userInfo"

cat > "$B/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleDevelopmentRegion</key><string>en</string>
<key>CFBundleIdentifier</key><string>com.apple.wallpaper.Custom.Custom</string>
<key>CFBundleInfoDictionaryVersion</key><string>6.0</string>
<key>CFBundleName</key><string>CustomCustom</string>
<key>CFBundlePackageType</key><string>BNDL</string>
<key>CFBundleShortVersionString</key><string>1.0</string>
<key>CFBundleVersion</key><string>1.0</string>
</dict></plist>
EOF

cat > "$B/Wallpaper.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>appearanceAware</key><false/>
<key>assets</key><dict><key>lockAndHome</key><dict><key>default</key><dict>
<key>fullSizeImageFileName</key><string>custom.heic</string>
<key>identifier</key><integer>$WID</integer>
<key>name</key><string>Custom</string>
<key>thumbnailImageFileName</key><string>custom.thumbnail.heic</string>
<key>type</key><string>Still</string>
</dict></dict></dict>
<key>disableParallax</key><true/>
<key>family</key><string>Custom</string>
<key>identifier</key><integer>$WID</integer>
<key>logicalScreenClass</key><string>any</string>
<key>name</key><string>Custom</string>
<key>thumbnailImageFileName</key><string>custom.thumbnail.heic</string>
<key>version</key><integer>1</integer>
</dict></plist>
EOF

sqlite3 "$DB" <<EOF
PRAGMA wal_checkpoint(TRUNCATE);
BEGIN;
INSERT INTO poster(UUID,providerId) VALUES('$NEW','com.apple.WallpaperKit.CollectionsPoster');
INSERT INTO posterRoleMembership VALUES('$NEW','PRPosterRoleLockScreen',(SELECT COALESCE(MAX(roleSortKey),0)+1 FROM posterRoleMembership WHERE roleId='PRPosterRoleLockScreen'));
INSERT INTO posterAttributes SELECT '$NEW',roleId,attributeIdentifier,attributePayload FROM posterAttributes WHERE posterUUID='$CUR' AND roleId='PRPosterRoleLockScreen' AND attributeIdentifier='PRPosterRoleAttributeTypeUsageMetadata';
DELETE FROM posterAttributes WHERE attributeIdentifier='SELECTED' AND roleId='PRPosterRoleLockScreen';
INSERT INTO posterAttributes VALUES('$NEW','PRPosterRoleLockScreen','SELECTED','1');
COMMIT;
PRAGMA wal_checkpoint(TRUNCATE);
EOF

xcrun simctl boot "$UDID"
xcrun simctl bootstatus "$UDID" -b >/dev/null
echo "wallpaper configuration $NEW installed"
