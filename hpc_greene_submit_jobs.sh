#!/bin/bash
#
#SBATCH --job-name=sampledata
#SBATCH --nodes=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=60g
#SBATCH --time=48:00:00
#SBATCH --output=/scratch/%u/logs/out.txt # Define output log location
#SBATCH --error=/scratch/%u/logs/err.txt # and the error logs for when it inevitably crashes
#SBATCH --mail-user=%u@nyu.edu
#SBATCH --mail-type=END #email me when it crashes or better, ends

./s0_download_data.sh
./s1_preprocess_data.sh
./s2_add_to_bids.sh
