# Makefile for python code
# 
# > make help
#
# The following commands can be used.
#
# init:  sets up environment and installs requirements
# install:  Installs development requirments
# format:  Formats the code with autopep8
# lint:  Runs flake8 on src, exit if critical rules are broken
# clean:  Remove build and cache files
# env:  Source venv and environment files for testing
# leave:  Cleanup and deactivate venv
# test:  Run pytest
# run:  Executes the logic 



define find.functions
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
endef

ifeq (run, $(firstword $(MAKECMDGOALS)))
  runargs := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  $(eval $(runargs):;@true)
endif


help:
	@echo 'The following commands can be used.'
	@echo ''
	$(call find.functions)


build: ## Build docker images (3)
build:
	docker-compose build

run: ## Run docker service
run: build
	docker-compose up -d

stop: ## Stop docker service
stop:
	docker-compose down -v

clean: ## Limpia los datos de la base de datos.
clean: stop
	rm -r ./schemas