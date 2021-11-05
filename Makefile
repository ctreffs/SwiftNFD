NFD_ROOT = 3rdparty/nativefiledialog
CLIB_ROOT = Sources/CNFD

.PHONY: copyLibFiles
copyLibFiles:
	cp -r "${NFD_ROOT}/src/" "${CLIB_ROOT}/"
	cp "${NFD_ROOT}/LICENSE" "${CLIB_ROOT}/"

.PHONY: clearLibFiles
clearLibFiles:
	rm -rdf ${CLIB_ROOT}/*