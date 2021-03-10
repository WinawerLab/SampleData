function which_software() {	
	if [[ "$CLUSTER" == "GREENE" ]]; then
		echo SINGULARITY
	else
		echo DOCKER
	fi
}

function singularity_pull() {
	umask u=rwx,g=rx,o=rx
	export SINGULARITY_CACHEDIR=/scratch/work/$USER/.singularity
	cd ~/singularity
	source=${1%/*}
	[ ${#source} -gt 0 ] && mkdir -p $source && cd $source
	singularity pull docker://${1}
}

function container_pull() {
	if [[ $CONTAINER_SOFTWARE == DOCKER ]]; then
		docker pull $@
	else		
		singularity_pull $@
	fi
}


}
function container_run() {
	if [[ $CONTAINER_SOFTWARE == DOCKER ]]; then
		docker run $@
	else
		singularity run $@
	fi
}