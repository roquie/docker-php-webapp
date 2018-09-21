IMAGE_NAME = roquie/docker-php-webapp
VERSION = latest

image:
	docker build -t $(IMAGE_NAME):$(VERSION) .

push:
	docker push $(IMAGE_NAME):$(VERSION)

run:
	docker run --rm -it -p 8080:8080 $(IMAGE_NAME):$(VERSION)

all: image push
