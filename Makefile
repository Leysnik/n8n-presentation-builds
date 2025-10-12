SHELL := /bin/bash
IMAGE := pptx-sender:latest
DC := docker compose

.PHONY: up run

start_services:
	docker-compose up -d
IMAGE=my-app
DOCKERFILE=Dockerfile

$(IMAGE): $(DOCKERFILE)
	docker build -t $(IMAGE) -f $(DOCKERFILE) .