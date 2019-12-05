## Download data, including:
#   1. DICOMS
#   2. Extras (AddToBIDS)

# check the output directory
if [ -n "$1" ] && [ -d "$1" ]
then OUTDIR="$1"
else echo "syntax; s0_download-data.sh <Output Directory>"
     exit 1
fi

curl -L --output "$OUTDIR/dicoms.zip"  https://osf.io/9up2d/download
curl -L --output "$OUTDIR/AddThisToBIDS.zip" https://osf.io/ea8b2/download

# Unzip
cd "$OUTDIR"
unzip AddThisToBIDS.zip && unzip dicoms.zip

exit 0

