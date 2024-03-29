.PHONY: help prepare-dev test test-disable-gpu doc serve-doc
.DEFAULT: help

help:
	@echo "make prepare-dev"
	@echo "       create and prepare development environment, use only once"
	@echo "make test"
	@echo "       run tests and linting on py36, py37, py38"
	@echo "make test-disable-gpu"
	@echo "       run test with gpu disabled"
	@echo "make serve-doc"
	@echo "       run documentation server for development"
	@echo "make doc"
	@echo "       build mkdocs documentation"

prepare-dev:
	python3 -m pip install virtualenv
	python3 -m venv metapred_venv
	. metapred_venv/activate && pip install -r requirements.txt
	. metapred_venv/activate && pip install -r requirements_dev.txt

test:
	. metapred_venv/bin/activate && tox

test-disable-gpu:
	. metapred_venv/bin/activate && CUDA_VISIBLE_DEVICES=-1 tox

doc:
	. metapred_venv/bin/activate && mkdocs build
	. metapred_venv/bin/activate && mkdocs gh-deploy

serve-doc:
	. metapred_venv/bin/activate && CUDA_VISIBLE_DEVICES=-1 mkdocs serve