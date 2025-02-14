all: getdeps docs
	hugo --theme=flatcar

getdeps:
	pip3 install --upgrade pyyaml

.PHONY: docs
docs:
	@echo "Fetching external docs…"
	@find ./content/docs -maxdepth 1 -type l -delete
	@python3 ./tools/fcl-fetch-version-data.py ./content/docs/_index.md.in > ./content/docs/_index.md
	python3 ./tools/docs-fetcher.py ./config.yaml

run:
	hugo server --theme=flatcar --buildFuture --watch --disableFastRender --config ./config.yaml\,./tmp_modules.yaml

build-preview: getdeps docs
	hugo --theme=flatcar -F -b ${DEPLOY_PRIME_URL}
