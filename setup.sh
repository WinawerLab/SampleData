## Export the path to the download data

# Define workspace variables

# If someone calls this with an argument, use that as the path for
# SAMPLE_DATA_DIR (though we'll add DownloadedData to it)
if [ -z ${1-} ]
then
    # if called without an argument, check to see whether `module list` returns
    # error code 0 (i.e., we're on a cluster (probably)).
    module list >/dev/null 2>&1
    if [ $? -eq 0 ]
    then
        # if so, then set SAMPLE_DATA_DIR to a directory in the user's scratch
        # directory
        SAMPLE_DATA_DIR="/scratch/$(whoami)/SampleData"
    else
        # else, set SAMPLE_DATA_DIR to a subfolder of directory that contains
        # this file. we use some gobblegook from stack overflow as a means to
        # find the directory containing the current function:
        # https://stackoverflow.com/a/246128
        SAMPLE_DATA_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    fi
else
    SAMPLE_DATA_DIR=$1
fi

SAMPLE_DATA_DIR="$SAMPLE_DATA_DIR/DownloadedData"
STUDY_DIR="$SAMPLE_DATA_DIR/BIDS"
# create the necessary directories, just to be safe
mkdir -p $SAMPLE_DATA_DIR
mkdir -p $STUDY_DIR
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
