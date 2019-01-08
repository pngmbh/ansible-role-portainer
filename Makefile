ROLENAME=$(shell basename "${PWD}")

test:
	docker run --rm -it \
		-v '${PWD}':/tmp/${ROLENAME} \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-w /tmp/${ROLENAME} \
		quay.io/ansible/molecule:latest \
		sudo molecule test
init:
	docker run --rm -it \
		-v '${PWD}':/tmp/${ROLENAME} \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-w /tmp/${ROLENAME} \
		quay.io/ansible/molecule:latest \
		sudo molecule init scenario -r ${ROLENAME} -s default -d docker
