# Constants
.DEFAULT_GOAL := help

#Targets
.PHONY: check
## Runs all repository tests
check: private_test

.PHONY: clean
## Deletes all files created by Make
clean: private_clean

.PHONY: test
## Runs all repository tests (alias for check)
test: private_test

# Includes
include make/private.mk
