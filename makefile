OWNER ?= bpack
REPO ?= jenkins
VERSION ?= latest

build:
	docker build -t $(OWNER)/$(REPO):$(VERSION) .

push: build
	docker login -u $(OWNER)
	docker push $(OWNER)/$(REPO):$(VERSION)

shell: build
	docker run --rm -i -t $(OWNER)/$(REPO):$(VERSION) /bin/bash

clean:
	docker rmi -f $(OWNER)/$(REPO)
	docker-compose kill
	docker-compose down -v --rmi all

run:
	docker-compose up -d jenkins

.PHONY: build push shell clean run
