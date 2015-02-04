GROUP=eavatar
NAME=redis
VERSION=2.8.19

all: build tag

build: Dockerfile overlayfs.tar
	docker build --rm -t $(GROUP)/$(NAME):$(VERSION) .

overlayfs.tar:
	cd overlayfs && docker build --rm -t $(NAME)-builder .
	docker run --rm $(NAME)-builder cat /overlayfs.tar > overlayfs.tar
	docker rmi $(NAME)-builder

tag:
	@if ! docker images $(GROUP)/$(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker tag $(GROUP)/$(NAME):$(VERSION) $(GROUP)/$(NAME):latest

clean:
	rm -f overlayfs.tar