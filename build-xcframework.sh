#!/usr/bin/env bash
set -euo pipefail

# Build XCFramework for rw-loaf (rw-loaf.xcodeproj, target: rw-loaf)
# Run from project root.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

PROJECT_NAME="rw-loaf"
SCHEME="rw-loaf"
PRODUCT_NAME="rw_loaf"
BUILD_DIR="${SCRIPT_DIR}/build"
DERIVED_PATH="${BUILD_DIR}/derived"
XCFRAMEWORK_PATH="${BUILD_DIR}/${PRODUCT_NAME}.xcframework"

echo "Building XCFramework for ${PROJECT_NAME} (scheme: ${SCHEME})"

# Clean previous build artifacts
rm -rf "${DERIVED_PATH}"
mkdir -p "${BUILD_DIR}"

# Build for iOS device
echo "Building for iOS (device)..."
xcodebuild build \
  -project "${PROJECT_NAME}.xcodeproj" \
  -scheme "${SCHEME}" \
  -sdk iphoneos \
  -configuration Release \
  -derivedDataPath "${DERIVED_PATH}" \
  ONLY_ACTIVE_ARCH=NO

# Build for iOS Simulator
echo "Building for iOS Simulator..."
xcodebuild build \
  -project "${PROJECT_NAME}.xcodeproj" \
  -scheme "${SCHEME}" \
  -sdk iphonesimulator \
  -configuration Release \
  -derivedDataPath "${DERIVED_PATH}" \
  ONLY_ACTIVE_ARCH=NO

FRAMEWORK_IOS="${DERIVED_PATH}/Build/Products/Release-iphoneos/${PRODUCT_NAME}.framework"
FRAMEWORK_SIM="${DERIVED_PATH}/Build/Products/Release-iphonesimulator/${PRODUCT_NAME}.framework"

for f in "${FRAMEWORK_IOS}" "${FRAMEWORK_SIM}"; do
  if [[ ! -d "$f" ]]; then
    echo "Expected framework not found: $f"
    exit 1
  fi
done

# Remove existing XCFramework so -create-xcframework doesn't complain
rm -rf "${XCFRAMEWORK_PATH}"

# Create XCFramework
echo "Creating XCFramework..."
xcodebuild -create-xcframework \
  -framework "${FRAMEWORK_IOS}" \
  -framework "${FRAMEWORK_SIM}" \
  -output "${XCFRAMEWORK_PATH}"

echo "Done. XCFramework: ${XCFRAMEWORK_PATH}"
