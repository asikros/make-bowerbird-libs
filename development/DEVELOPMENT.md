# Development Guide

## Overview

This repository contains common utility libraries for Bowerbird Make-based projects.

## Structure

```
make-bowerbird-libs/
├── src/bowerbird-libs/        # Library source files
│   ├── bowerbird-libs.mk      # Main entry point
│   └── bowerbird-kwargs.mk    # Keyword argument parsing library
├── test/bowerbird-libs/       # Test files
├── development/               # Development documentation
│   ├── DEVELOPMENT.md         # This file
│   └── proposals/             # Design proposals
│       ├── INDEX.md           # Proposal index
│       ├── accepted/          # Accepted proposals
│       ├── draft/             # Draft proposals
│       └── rejected/          # Rejected proposals
├── make/                      # Build system files
│   ├── deps.mk                # Dependency declarations
│   └── private.mk             # Private build targets
├── Makefile                   # Main makefile
├── bowerbird.mk               # External entry point
└── README.md                  # User documentation
```

## Testing

Run all tests:

```bash
make check
```

Run tests in development mode (preserves .git directories):

```bash
make check -- --bowerbird-dev-mode
```

## Design Proposals

See [proposals/INDEX.md](proposals/INDEX.md) for information on creating and managing proposals.
