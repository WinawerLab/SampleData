function which_software() {	
	if [[ "$CLUSTER" == "GREENE" ]]; then
		echo SINGULARITY
	else
		echo DOCKER
	fi
}

function container_pull() {
	if [[ $CONTAINER_SOFTWARE == DOCKER ]]; then
		docker pull $@
	else
		singularity pull docker://$@
	fi
}
