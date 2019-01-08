SHELL=/bin/bash
ROLENAME=$(shell basename "${PWD}")
TESTIMAGENAME=molecule-test

test: build-testimage
	docker run --rm -it \
		-v '${PWD}':/tmp/${ROLENAME} \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-w /tmp/${ROLENAME} \
		${TESTIMAGENAME} \
		sudo molecule test
		# sudo molecule init scenario -r ${ROLENAME} -s default -d docker

build-testimage:
	docker build -t ${TESTIMAGENAME} -f <( \
		echo "FROM quay.io/ansible/molecule:latest"; \
		echo "RUN sudo pip install docker-py"; \
	) .
