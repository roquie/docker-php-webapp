IMAGE_NAME = roquie/docker-php-webapp
VERSION = latest

build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

push:
	docker push $(IMAGE_NAME):$(VERSION)

all: build push
