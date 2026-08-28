#!/bin/sh
# Patch the bundled JRE's print service classes so that printing works
# inside the Flatpak sandbox.
#
# The Oracle JRE 8 has one issue, UnixPrintServiceLookup hardcodes
# /usr/sbin/lpc which don't exist in the sandbox.
#
# We fix both by binary-patching the class files (both strings happen
# to be the same length as their replacements) and loading them via
# -Xbootclasspath/p: so the original rt.jar is not modified.

set -e

PATCH_DIR=/app/lib/sweethome3d/cups-patch
CLASSES_DIR="${PATCH_DIR}/sun/print"
RT_JAR=/app/lib/sweethome3d/runtime/lib/rt.jar

mkdir -p "${CLASSES_DIR}"

unzip -o "${RT_JAR}" 'sun/print/UnixPrintService*.class' -d "${PATCH_DIR}"

sed -i -e 's|/usr/sbin/lpc|/app/sbin/lpc|g' \
    ${CLASSES_DIR}/UnixPrintService*.class

sed -i 's|runtime/bin/java |runtime/bin/java -Xbootclasspath/p:"$PROGRAM_DIR"/cups-patch |' \
    /app/lib/sweethome3d/SweetHome3D \
    /app/lib/sweethome3d/SweetHome3D-Java3D-1_5_2
