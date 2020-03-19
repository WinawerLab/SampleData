## Download data, including:
#   1. DICOMS
#   2. Extras (AddToBIDS)

# Exit upon any error
set -euxo pipefail

source setup.sh

curl -L --output "$SAMPLE_DATA_DIR/dicoms.zip"  https://osf.io/9up2d/download
curl -L --output "$SAMPLE_DATA_DIR/AddThisToBIDS.zip" https://osf.io/ea8b2/download

# Unzip
unzip "$SAMPLE_DATA_DIR/AddThisToBIDS.zip" -d "$SAMPLE_DATA_DIR" && unzip "$SAMPLE_DATA_DIR/dicoms.zip" -d "$SAMPLE_DATA_DIR"

exit 0
