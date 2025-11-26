all:

build:
	@./local-build.sh

try-local:
	@docker run \
		--rm -it \
		n8n:latest

try-published:
	@docker run \
		--rm -it \
		ghcr.io/rikonor/n8n:latest
