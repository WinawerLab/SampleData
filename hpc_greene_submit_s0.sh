#!/bin/bash
#
#SBATCH --job-name=sampledata
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=12g
#SBATCH --time=1:00:00
#SBATCH --output=/scratch/$USER/logs/out.txt # Define output log location
#SBATCH --error=/scratch/jaw288/logs/err.txt # and the error logs for when it inevitably crashes
#SBATCH --mail-user=jaw288@nyu.edu
#SBATCH --mail-type=END #email me when it crashes or better, ends

./s0_download-data.sh
