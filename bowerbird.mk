_PATH := $(dir $(lastword $(MAKEFILE_LIST)))
include $(_PATH)/src/bowerbird-libs/bowerbird-libs.mk
