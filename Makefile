SHELL := /bin/bash
IMAGE := pptx-sender:latest
DC := docker compose

.PHONY: up run

start_services:
	docker-compose up -d
send_file:
	docker build -t $(IMAGE) .
	docker run --rm --network host -v $(PWD):/app -w /app $(IMAGE)
