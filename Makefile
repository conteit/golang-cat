MAIN_GO_EXECUTABLE ?= go
SRC_DIR ?= $(GOPATH)/src/cat
OUTPUT_DIR ?= $(GOPATH)/bin/cat
DIST_DIRS := find * -type d -exec
VERSION ?= 1.0.0

build:
	$(MAIN_GO_EXECUTABLE) build -o cat -ldflags "-X main.version=${VERSION}" main.go

clean:
	rm -f ./cat
	rm -rf $(OUTPUT_DIR)

bootstrap-dist:
	$(MAIN_GO_EXECUTABLE) get -u github.com/Masterminds/gox

build-all: bootstrap-dist
	$(GOPATH)/bin/gox -verbose \
	-ldflags "-X main.version=$(VERSION)" \
	-os="darwin windows" \
	-arch="amd64" \
	-osarch="!darwin/arm64" \
	-output="$(OUTPUT_DIR)/{{.OS}}-{{.Arch}}/{{.Dir}}" .

dist: build-all
	echo "$(VERSION)" > $(OUTPUT_DIR)/VERSION && \
	cd $(OUTPUT_DIR) && \
	$(DIST_DIRS) cp $(OUTPUT_DIR)/VERSION {} \;  && \
	$(DIST_DIRS) zip -r cat-$(VERSION)-{}.zip {} \; && \
	cd ..

.DEFAULT_GOAL := dist
.PHONY := dist
default: dist ;
