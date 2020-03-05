## Export the path to the download data

# This gobblegook comes from stack overflow as a means to find the directory containing the current function: https://stackoverflow.com/a/246128
SAMPLE_DATA_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SAMPLE_DATA_DIR="$SAMPLE_DATA_DIR/DownloadedData"
export SAMPLE_DATA_DIR

echo $SAMPLE_DATA_DIR

# exit 0
