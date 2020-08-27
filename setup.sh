## Export the path to the download data

# Define workspace variables
# 	For SAMPLE_DATA_DIR, we use some gobblegook from stack overflow as a means to find the directory containing the current function: https://stackoverflow.com/a/246128
SAMPLE_DATA_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SAMPLE_DATA_DIR="$SAMPLE_DATA_DIR/DownloadedData"
STUDY_DIR="$SAMPLE_DATA_DIR/BIDS"
SUBJECT_ID=wlsubj042
SESSION_ID=01 
LOG_DIR=${STUDY_DIR}/derivatives/logs/sub-${SUBJECT_ID}

export SUBJECT_ID
export SESSION_ID
export SAMPLE_DATA_DIR
export STUDY_DIR
export LOG_DIR

echo $SUBJECT_ID
echo $SESSION_ID
echo $SAMPLE_DATA_DIR
echo $STUDY_DIR
echo $LOG_DIR

# exit 0
