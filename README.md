# Bowerbird Libraries

[![Makefile CI](https://github.com/asikros/make-bowerbird-libs/actions/workflows/makefile.yml/badge.svg)](https://github.com/asikros/make-bowerbird-libs/actions/workflows/makefile.yml)

Common utility libraries for Bowerbird Make-based projects.

## Overview

This repository provides reusable Make libraries and utilities that can be shared across Bowerbird projects.

## Libraries

### Keyword Arguments (`bowerbird-kwargs.mk`)

A library for parsing keyword arguments in Make macros, enabling cleaner and more maintainable function signatures.

**Features:**
- Parse `key=value` pairs from macro arguments
- Set default values for optional parameters
- Validate required parameters with custom error messages
- Automatic cleanup to prevent variable leaking between calls

**Example:**

```makefile
include path/to/bowerbird-libs/bowerbird.mk

define my-macro
$(eval \
    $(call bowerbird::lib::kwargs-parse,$1,$2,$3) \
    $(call bowerbird::lib::kwargs-default,optional,default-value) \
    $(call bowerbird::lib::kwargs-require,required) \
)
    @echo "Required: $(call bowerbird::lib::kwargs,required)"
    @echo "Optional: $(call bowerbird::lib::kwargs,optional)"
endef

$(call my-macro,required=foo,optional=bar)
```

## Installation

Include this repository as a dependency using `bowerbird::git-dependency`:

```makefile
$(call bowerbird::git-dependency, \
    name=bowerbird-libs, \
    path=$(WORKDIR_DEPS)/bowerbird-libs, \
    url=https://github.com/asikros/make-bowerbird-libs.git, \
    branch=main, \
    entry=bowerbird.mk)
```

## Testing

Run all tests:

```bash
make check
```

## License

MIT License - see [LICENSE](LICENSE) for details.
