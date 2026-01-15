# Error Checking
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

# Dependencies
#
#	Loads the bowerbird-deps system and declares all project dependencies.
#	Dependencies are cloned into $(WORKDIR_DEPS) and included automatically.
#

# Load Bowerbird Dependency Tools
BOWERBIRD_DEPS.MK := $(WORKDIR_DEPS)/bowerbird-deps/bowerbird_deps.mk
$(BOWERBIRD_DEPS.MK):
	@curl --silent --show-error --fail --create-dirs -o $@ -L \
https://raw.githubusercontent.com/asikros/make-bowerbird-deps/\
main/src/bowerbird-deps/bowerbird-deps.mk
include $(BOWERBIRD_DEPS.MK)

# Initialize override variables to avoid undefined variable warnings
bowerbird-help.path ?=
bowerbird-help.url ?=
bowerbird-help.branch ?=
bowerbird-help.revision ?=
bowerbird-help.entry ?=
bowerbird-githooks.path ?=
bowerbird-githooks.url ?=
bowerbird-githooks.branch ?=
bowerbird-githooks.revision ?=
bowerbird-githooks.entry ?=
bowerbird-test.path ?=
bowerbird-test.url ?=
bowerbird-test.branch ?=
bowerbird-test.revision ?=
bowerbird-test.entry ?=

$(call bowerbird::git-dependency, \
	name=bowerbird-help, \
	path=$(WORKDIR_DEPS)/bowerbird-help, \
	url=https://github.com/asikros/make-bowerbird-help.git, \
	branch=main, \
	entry=bowerbird.mk)

$(call bowerbird::git-dependency, \
	name=bowerbird-githooks, \
	path=$(WORKDIR_DEPS)/bowerbird-githooks, \
	url=https://github.com/asikros/make-bowerbird-githooks.git, \
	branch=main, \
	entry=bowerbird.mk)

$(call bowerbird::git-dependency, \
	name=bowerbird-test, \
	path=$(WORKDIR_DEPS)/bowerbird-test, \
	url=https://github.com/asikros/make-bowerbird-test.git, \
	branch=main, \
	entry=bowerbird.mk)
