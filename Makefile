HOST_UID              := $(shell id -u)
HOST_GID              := $(shell id -g)
DOCKER_BRIDGE_HOST_IP := $(shell docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}')
BUILD_COMMIT          := "$(shell git describe --always --abbrev=40 --dirty)"
BUILD_DATE            := "$(shell date --rfc-3339=seconds)"
DOCKER_COMPOSE_VARS   := DOCKER_BRIDGE_HOST_IP=$(DOCKER_BRIDGE_HOST_IP) BUILD_COMMIT=$(BUILD_COMMIT) \
                         BUILD_DATE=$(BUILD_DATE) HOST_UID=$(HOST_UID) HOST_GID=$(HOST_GID)

start:
	$(DOCKER_COMPOSE_VARS) docker-compose up --force-recreate --build --abort-on-container-exit

down:
	$(DOCKER_COMPOSE_VARS) docker-compose down

