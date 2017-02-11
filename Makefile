#
# Project:   xonotic-map-repository-docker
# Copyright: (c) 2017 by Tyler "-z-" Mulligan <z@xnz.me> and contributors
# License:   MIT, see the LICENSE file for more details
#
# A GNU Makefile for the project.
#

DEV_DIR=~/dev

SANDBOX = $(DEV_DIR)/xonotic-map-repository-docker
REPO_API = $(DEV_DIR)/xonotic-map-repository-api
REPO_WEBSITE = $(DEV_DIR)/xonotic-map-repository-web

.PHONY: help clean build

help:
	@echo "Use \`make <target>', where <target> is one of the following:"
	@echo "  clean          - remove all generated files"
	@echo "  build          - build packages"

clean:
	@find projects/packages/ -name '*.tar.gz' -exec rm -f {} +
	@find projects/builds/ -name '*.local' -exec rm -Rf {} +

build:
	bash -c "cd $(REPO_API) && venv/bin/python setup.py sdist --dist-dir $(SANDBOX)/projects/packages"

	rsync -azvh --exclude=*resources* $(REPO_WEBSITE)/ projects/builds/www.xonotic-repo.local