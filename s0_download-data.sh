## Download data, including:
#   1. DICOMS
#   2. Extras (AddToBIDS)

# Exit upon any error
set -euxo pipefail

DIRN=`dirname $0`
source $DIRN/setup.sh ${1-}


#Downlad

if  [[ -f "$SAMPLE_DATA_DIR/dicoms.zip" && -f "$SAMPLE_DATA_DIR/AddThisToBIDS.zip" ]]; then

    echo "Data will not be downloaded - files already exist"

else

    curl -L --output "$SAMPLE_DATA_DIR/dicoms.zip"  https://osf.io/9up2d/download
    curl -L --output "$SAMPLE_DATA_DIR/AddThisToBIDS.zip" https://osf.io/ea8b2/download
fi


#Unzip


if  [[ -d "$SAMPLE_DATA_DIR/dicoms" && -d "$SAMPLE_DATA_DIR/AddThisToBIDSFolder" ]]; then


    echo "Data will not be unzipped - files already exist"

else


    unzip "$SAMPLE_DATA_DIR/AddThisToBIDS.zip" -d "$SAMPLE_DATA_DIR" && unzip "$SAMPLE_DATA_DIR/dicoms.zip" -d "$SAMPLE_DATA_DIR"

fi

exit 0
