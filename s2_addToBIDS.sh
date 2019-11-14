#! /bin/bash
#add in the stimfiles and other extras
export COPYFILE_DISABLE=1
rsync -avzh ./AddThisToBIDSFolder/  ./BIDS/
