$(error make-bowerbird-libs is DEPRECATED. Use make-bowerbird-core instead: https://github.com/asikros/make-bowerbird-core)

_PATH := $(dir $(lastword $(MAKEFILE_LIST)))
include $(_PATH)/src/bowerbird-libs/bowerbird-kwargs.mk
