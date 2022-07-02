.DEFAULT_GOAL := help
.PHONY: all help

USER_NAME?=vlashm

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

all: build_all push_all ## Build and push all

build_all: build_prometheus build_ui build_comment build_post  ## Build all images

build_prometheus: ## Build Prometheus
	docker build -t $(USER_NAME)/prometheus $(CURDIR)/monitoring/prometheus

build_ui: ## Build UI
	@echo `git show --format="%h" HEAD | head -1` > $(CURDIR)/src/ui/build_info.txt
	@echo `git rev-parse --abbrev-ref HEAD` >> $(CURDIR)/src/ui/build_info.txt
	docker build -t $(USER_NAME)/ui $(CURDIR)/src/ui

build_post: ## Build Post
	@echo `git show --format="%h" HEAD | head -1` > $(CURDIR)/src/post-py/build_info.txt
	@echo `git rev-parse --abbrev-ref HEAD` >> $(CURDIR)/src/post-py/build_info.txt
	docker build -t $(USER_NAME)/post src/post-py

build_comment: ## Build Comment
	@echo `git show --format="%h" HEAD | head -1` > $(CURDIR)/src/comment/build_info.txt
	@echo `git rev-parse --abbrev-ref HEAD` >> $(CURDIR)/src/comment/build_info.txt
	docker build -t $(USER_NAME)/comment $(CURDIR)/src/comment

push_all: push_prometheus push_ui push_post push_comment ## Push all images

push_prometheus: ## Rush Prometheus
	docker push $(USER_NAME)/prometheus

push_ui: ## Push UI
	docker push $(USER_NAME)/ui

push_post: ## Push Post
	docker push $(USER_NAME)/post

push_comment: ## Push comment
	docker push $(USER_NAME)/comment

start_app: ## Start app
	docker compose -f $(CURDIR)/docker/docker-compose.yml up -d

down_app: ## Dowm app
	docker compose -f $(CURDIR)/docker/docker-compose.yml down
