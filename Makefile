PKG_VERSION := $(shell yq e ".version" manifest.yaml)
PKG_ID := $(shell yq e ".id" manifest.yaml)

# delete the target of a rule if it has changed and its recipe exits with a nonzero exit status
.DELETE_ON_ERROR:

all: verify

clean:
	rm -rf docker-images
	rm -f  $(PKG_ID).s9pk
	rm -f image.tar
	rm -f scripts/*.js

install: all
	start-cli package install ipfs.s9pk

verify: $(PKG_ID).s9pk
	start-sdk verify s9pk $(PKG_ID).s9pk

$(PKG_ID).s9pk: manifest.yaml instructions.md scripts/embassy.js LICENSE docker-images/aarch64.tar docker-images/x86_64.tar
	start-sdk pack

docker-images/aarch64.tar: Dockerfile docker_entrypoint.sh
	mkdir -p docker-images
	docker buildx  build --tag qbittorrent --load  --build-arg ARCH=aarch64 --build-arg PLATFORM=arm64 --platform=linux/arm64 -o type=docker,dest=docker-images/aarch64.tar .

docker-images/x86_64.tar: Dockerfile docker_entrypoint.sh check-web.sh $(IPFS_SRC)
	mkdir -p docker-images
	ddocker buildx  build --tag qbittorrent --load  --build-arg ARCH=x86_64 --build-arg PLATFORM=amd64 --platform=linux/amd64 -o type=docker,dest=docker-images/x86_64.tar .
