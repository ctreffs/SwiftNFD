SWIFT_PACKAGE_VERSION := $(shell swift package tools-version)
NFD_ROOT = 3rdparty/nativefiledialog
CLIB_ROOT = Sources/CNFD

# Lint fix and format code.
.PHONY: lint-fix
lint-fix:
	mint run swiftlint --fix --quiet
	mint run swiftformat --quiet --swiftversion ${SWIFT_PACKAGE_VERSION} .

.PHONY: copyLibFiles
copyLibFiles:
	cp -r "${NFD_ROOT}/src/" "${CLIB_ROOT}/"
	cp "${NFD_ROOT}/LICENSE" "${CLIB_ROOT}/"

.PHONY: clearLibFiles
clearLibFiles:
	rm -rdf ${CLIB_ROOT}/*

.PHONY: build-release
build-release:
	swift build -c release

.PHONY: build-release-verbose
build-release-verbose:
	swift build -c release -v