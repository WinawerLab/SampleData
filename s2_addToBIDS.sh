#! /bin/bash
#add in the stimfiles and other extras

# Exit upon any error
set -euxo pipefail

# Get the path to the sample data, defined as SAMPLE_DATA_DIR
source setup.sh

# COPY_DISABLE=1 to not copy the .DS_Store
export COPYFILE_DISABLE=1

rsync -avzh "$SAMPLE_DATA_DIR/AddThisToBIDSFolder/"  "$SAMPLE_DATA_DIR/BIDS/"
