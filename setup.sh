## Export the path to the download data

# Where does code live?
CODE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Source the subroutines
source "$CODE_DIR"/subroutines/utils.sh

# Define workspace variables

# Path to downloaded data
# 	If someone calls this with an argument, use that as the path for
# 	SAMPLE_DATA_DIR (though we'll add DownloadedData to it)
if [ -z ${1-} ]
then
    # if called without an argument, check to see whether `module` is found on your path (i.e., we're on a cluster (probably)).
    if [[ "$(on_cluster)" == "TRUE" ]] # 
    then
        # else, set SAMPLE_DATA_DIR to a directory in the user's scratch
        # directory
        SAMPLE_DATA_DIR="/scratch/$(whoami)/SampleData"    
        SINGULARITY_PULLFOLDER="/scratch/$(whoami)/Singularity" 
        mkdir -p $SINGULARITY_PULLFOLDER 
        load_modules

    else
        # set SAMPLE_DATA_DIR to a subfolder of directory that contains
        # this file. we use some gobblegook from stack overflow as a means to
        # find the directory containing the current function:
        # https://stackoverflow.com/a/246128
        SAMPLE_DATA_DIR="$CODE_DIR"        
    fi
else
    SAMPLE_DATA_DIR=$1
fi
SAMPLE_DATA_DIR="$SAMPLE_DATA_DIR/DownloadedData"

# Path to BIDS directory
STUDY_DIR="$SAMPLE_DATA_DIR/BIDS"
# create the necessary directories, just to be safe
mkdir -p $SAMPLE_DATA_DIR 
mkdir -p $STUDY_DIR

# BIDS specific variables
SUBJECT_ID=wlsubj042
SESSION_ID=01 
LOG_DIR=${STUDY_DIR}/derivatives/logs/sub-${SUBJECT_ID}

# Which container software to use 
CONTAINER_SOFTWARE=`which_software`

export SUBJECT_ID
export SESSION_ID
export SAMPLE_DATA_DIR
export STUDY_DIR
export LOG_DIR
export CODE_DIR
export CONTAINER_SOFTWARE
export SINGULARITY_PULLFOLDER

echo $SUBJECT_ID
echo $SESSION_ID
echo $SAMPLE_DATA_DIR
echo $STUDY_DIR
echo $LOG_DIR
echo $CODE_DIR
echo $CONTAINER_SOFTWARE
echo $SINGULARITY_PULLFOLDER

# debug
#  echo $CLUSTER 
#  echo $(on_cluster)
# exit 0

 