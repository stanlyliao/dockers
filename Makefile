.DEFAULT_GOAL:=help

SHELL:=/bin/bash

DOCKERS:=mysql redis postgres

.PHONY: help start stop

help:  ## 說明
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

start: ## 啟用 container
	@for container in $(DOCKERS) ; do \
		docker-compose -f ./$$container/docker-compose.yml up -d ; \
	done

stop: ## 停用 containers
	@for container in $(DOCKERS) ; do \
		docker-compose -f ./$$container/docker-compose.yml down ; \
	done