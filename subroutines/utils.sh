function on_cluster() {
	if [[ "$CLUSTER" == "GREENE" ]]; then
		echo TRUE
	else
		echo FALSE
	fi
}

function which_software() {	
	if [[ "$(on_cluster)" == "TRUE" ]]; then
		echo SINGULARITY
	else
		echo DOCKER
	fi
}

function load_modules() {
	if [[ "$(on_cluster)" == "TRUE" ]]; then
		module load freesurfer/6.0.0
	fi
}

function singularity_pull() {
	umask u=rwx,g=rx,o=rx
	singularity pull docker://${1}
}

function container_pull() {
	if [[ $CONTAINER_SOFTWARE == DOCKER ]]; then
		docker pull $@
	else		
		singularity_pull $@
	fi
}

function container_run() {
	if [[ $CONTAINER_SOFTWARE == DOCKER ]]; then
		docker run $@
	else
		singularity run $@
	fi
}