#!/bin/sh
#
#  upload_dsym.sh
#  LogDropSDK
#
#  Created by Initial Code on 28.03.2025.
#

echo "LogDrop - debugMessage: Creating dSYM tar.gz and uploading to backend..."

if [ "$EFFECTIVE_PLATFORM_NAME" = "-iphonesimulator" ]; then
  echo "LogDrop - debugMessage: Simulator build detected. Skipping dSYM upload."
  exit 0
fi

APP_DSYM="${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
if [ ! -d "$APP_DSYM" ]; then
  echo "LogDrop - debugMessage: dSYM not found: $APP_DSYM"
  exit 1
fi

echo "LogDrop - debugMessage: dSYM found: $APP_DSYM"

DSYM_NAME=$(basename "$APP_DSYM")
DWARF_BINARY="${APP_DSYM}/Contents/Resources/DWARF/${PRODUCT_NAME}"
if [ ! -f "$DWARF_BINARY" ]; then
  echo "LogDrop - debugMessage: DWARF binary not found: $DWARF_BINARY"
  exit 1
fi
echo "LogDrop - debugMessage: DWARF binary found: $DWARF_BINARY"

DSYM_UUID=$(dwarfdump --uuid "$DWARF_BINARY" 2>/dev/null | grep "UUID:" | head -n 1 | awk '{print $2}')
if [ -z "$DSYM_UUID" ]; then
  echo "LogDrop - debugMessage: Failed to extract UUID from DWARF binary."
  exit 1
fi

APP_VERSION=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "${INFOPLIST_FILE}")
BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c 'Print CFBundleVersion' "${INFOPLIST_FILE}")

ARCHIVE_NAME="${DSYM_NAME}.tar.gz"
echo "LogDrop - debugMessage: Compressing dSYM bundle: ${DSYM_NAME}"
tar -czf "$ARCHIVE_NAME" -C "$(dirname "$APP_DSYM")" "$DSYM_NAME"
if [ $? -ne 0 ]; then
  echo "LogDrop - debugMessage: Compression failed."
  exit 1
fi

BASE_URL=${LOGDROP_BASE_URL:-"https://server.logdrop.io/api/"}

BACKEND_URL="${BASE_URL}crash/upload/dsym"
API_KEY=${LOGDROP_API_KEY:-""}

RESPONSE_BODY=$(mktemp)
echo "LogDrop - debugMessage: Uploading: $ARCHIVE_NAME"
http_code=$(curl -s -o "$RESPONSE_BODY" -w "%{http_code}" -X POST "$BACKEND_URL" \
  -H "x-api-key: ${API_KEY}" \
  -F "dsym=@${ARCHIVE_NAME};filename=${ARCHIVE_NAME}" \
  -F "version=${APP_VERSION}" \
  -F "build=${BUILD_NUMBER}" \
  -F "dsymUuid=${DSYM_UUID}")

if [ "$http_code" != "200" ]; then
  echo "LogDrop - debugMessage: dSYM upload failed. HTTP status code: $http_code"
  cat "$RESPONSE_BODY"
  rm -f "$RESPONSE_BODY"
  exit 1
fi

rm -f "$ARCHIVE_NAME"
rm -f "$RESPONSE_BODY"

echo "LogDrop - debugMessage: Upload completed: ${DSYM_NAME} → UUID: ${DSYM_UUID}"
exit 0