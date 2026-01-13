# bowerbird-libs.mk
#
#	Common utility libraries for Bowerbird Make-based projects.
#
#	This file serves as the entry point for all Bowerbird library utilities.
#

# Include keyword argument parsing library
include $(dir $(lastword $(MAKEFILE_LIST)))bowerbird-kwargs.mk
