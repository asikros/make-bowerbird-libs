# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

```markdown
## [Unreleased] - YYYY-MM-DD

### Added
### Changed
### Deprecated
### Fixed
- Removed `.NOTPARALLEL` directive for Make 3.81 compatibility
### Security
```

## [Unreleased]

### Deprecated
- **ENTIRE REPOSITORY DEPRECATED**: This repository has been consolidated into [make-bowerbird-core](https://github.com/asikros/make-bowerbird-core)
- All functionality from make-bowerbird-libs has been integrated into make-bowerbird-core
- New projects should use make-bowerbird-core instead
- Existing projects should migrate to make-bowerbird-core for continued support and updates
- See [migration guide](https://github.com/asikros/make-bowerbird-core#migration-from-deps--libs) for upgrade instructions

### Changed
- Added deprecation error message to `bowerbird.mk` entry point
- Updated README with deprecation notice and migration instructions

---

## [0.1.0] - 2026-01-15

### Added
- Initial release with keyword argument parsing library
- Helper macros: `kwargs-parse`, `kwargs`, `kwargs-defined`, `kwargs-default`, `kwargs-require`
- Comprehensive test suite
- Parse keyword arguments with flexible spacing
- Set default values for optional parameters
- Validate required parameters
- Automatic variable cleanup between calls
- Support for up to 10 arguments

### Fixed
- Removed `.NOTPARALLEL` directive for Make 3.81 compatibility

[Unreleased]: https://github.com/asikros/make-bowerbird-libs/commits/main
[0.1.0]: https://github.com/asikros/make-bowerbird-libs/releases/tag/v0.1.0
