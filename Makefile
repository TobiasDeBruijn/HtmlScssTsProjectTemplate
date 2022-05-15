.PHONY: build clean
all: build

install:
	npm i
	sudo apt install inotify-tools

clean:
	rm -rf build/ node_modules/ package-lock.json

watch: install
	$(shell ./watch.sh)

build: install
	npx tsc
	sass src/css:build/css/
	cp -r src/html build/html