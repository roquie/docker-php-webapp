IMAGE_NAME = roquie/docker-php-webapp
VERSION = latest
FILE = Dockerfile

image:
	docker build -f $(FILE) -t $(IMAGE_NAME):$(VERSION) .

push:
	docker push $(IMAGE_NAME):$(VERSION)

run:
	docker run --rm --init -it -p 8080:8080 $(IMAGE_NAME):$(VERSION)

all: image push
