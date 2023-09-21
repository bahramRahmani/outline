PKG_VERSION := $(shell yq e ".version" manifest.yaml)
PKG_ID := $(shell yq e ".id" manifest.yaml)
TS_FILES := $(shell find . -name \*.ts )

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

$(PKG_ID).s9pk: manifest.yaml instructions.md scripts/embassy.js LICENSE docker-images/x86_64.tar
        start-sdk pack
docker-images/x86_64.tar: Dockerfile docker_entrypoint.sh check-web.sh
        mkdir -p docker-images
        docker buildx  build --tag start9/$(PKG_ID)/main:$(PKG_VERSION) --load  --build-arg ARCH=x86_64 --build-arg PLATFORM=amd64 --platform=linux/amd64 -o type=docker,dest=docker-images/x86_64.tar .
