DFILE_VERSION="2019-12-09"
CWALLET_VERSION="2019-12-09"

build:
	docker build . --build-arg CWALLET_VERSION="${CWALLET_VERSION}" --build-arg DFILE_VERSION="${DFILE_VERSION}" -t adalove/cardano-playground:${DFILE_VERSION}
