# Error Checking
WORKDIR_DEPS ?= $(error ERROR: Undefined variable WORKDIR_DEPS)

# Dependencies
#
#	Loads the bowerbird-deps system and declares all project dependencies.
#	Dependencies are cloned into $(WORKDIR_DEPS) and included automatically.
#
#	Note: We use the low-level positional API (bowerbird::deps::git-dependency-low-level) to bootstrap
#	all dependencies. This avoids a chicken-and-egg problem where the kwargs-based API
#	requires bowerbird-libs (this project) to be loaded first.
#

# Load Bowerbird Dependency Tools
# Define override variables with defaults
bowerbird-deps.url ?= https://raw.githubusercontent.com/asikros/make-bowerbird-deps
bowerbird-deps.branch ?= main
bowerbird-deps.path ?= $(WORKDIR_DEPS)/bowerbird-deps
bowerbird-deps.entry ?= bowerbird_deps.mk

$(bowerbird-deps.path)/$(bowerbird-deps.entry):
	@curl --silent --show-error --fail --create-dirs -o $@ -L \
$(bowerbird-deps.url)/$(bowerbird-deps.branch)/src/bowerbird-deps/bowerbird-deps.mk
include $(bowerbird-deps.path)/$(bowerbird-deps.entry)

# Bootstrap all dependencies using low-level positional API
# Override variables are initialized automatically by git-dependency-low-level
$(call bowerbird::deps::git-dependency-low-level,bowerbird-help,$(WORKDIR_DEPS)/bowerbird-help,https://github.com/asikros/make-bowerbird-help.git,main,,bowerbird.mk)
$(call bowerbird::deps::git-dependency-low-level,bowerbird-githooks,$(WORKDIR_DEPS)/bowerbird-githooks,https://github.com/asikros/make-bowerbird-githooks.git,main,,bowerbird.mk)
$(call bowerbird::deps::git-dependency-low-level,bowerbird-test,$(WORKDIR_DEPS)/bowerbird-test,https://github.com/asikros/make-bowerbird-test.git,main,,bowerbird.mk)
