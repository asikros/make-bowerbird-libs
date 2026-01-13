# Bowerbird Keyword Arguments Library
#
# Provides a general-purpose keyword argument parsing system for Make macros.
# This allows macros to accept named parameters in key=value format with flexible spacing.
#
# Usage:
#   1. Call bowerbird::lib::kwargs-parse with all arguments
#   2. Use helper functions to access and validate keyword arguments
#
# Example:
#   $(call bowerbird::lib::kwargs-parse,$1,$2,$3,$4,$5)
#   $(call bowerbird::lib::kwargs-require,name,'name' parameter is required)
#   $(call bowerbird::lib::kwargs-default,branch,main)
#   $(eval my_name := $(call bowerbird::lib::kwargs,name))

# Define comma and space variables (needed for substitution)
__BOWERBIRD_LIBS_KWARGS_COMMA := ,
__BOWERBIRD_LIBS_KWARGS_EMPTY :=
__BOWERBIRD_LIBS_KWARGS_SPACE := $(__BOWERBIRD_LIBS_KWARGS_EMPTY) $(__BOWERBIRD_LIBS_KWARGS_EMPTY)

# Prefix for storing parsed keyword argument values
__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX := __BOWERBIRD_LIBS_KWARGS_VALUE

# Keyword arguments limit (we support one less than this value)
__BOWERBIRD_LIBS_KWARGS_ARGS_LIMIT := 11

# Helper for building argument list (excludes position 1 and ARGS_LIMIT)
# Stored as immediate value to avoid re-executing shell command on each use
__BOWERBIRD_LIBS_KWARGS_ARG_NUMS := $(filter-out $(__BOWERBIRD_LIBS_KWARGS_ARGS_LIMIT),$(shell seq 1 $(__BOWERBIRD_LIBS_KWARGS_ARGS_LIMIT)))

# bowerbird::lib::kwargs-parse
#
#	Parses keyword arguments with flexible spacing.
#
#	Args:
#		$1-$N: Keyword arguments in format key=value (flexible spacing supported).
#
#	Returns:
#		Sets $(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).<key> variables for each parsed key=value pair.
#		Clears any existing $(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).* variables to prevent leaking.
#		Errors if KEYWORD_ARGS_LIMIT arguments are reached.
#
#	Example:
#		$(call bowerbird::lib::kwargs-parse,name=foo,path=bar,url=baz)
#		$(call bowerbird::lib::kwargs,name)  # Returns: foo
#
define bowerbird::lib::kwargs-parse
# Clear existing keyword args to prevent leaking
$(foreach v,$(filter $(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).%,$(.VARIABLES)),$(eval $v :=))
# Build argument list, filtering to only defined arguments
$(eval __DEFINED_ARGS := $(foreach n,$(__BOWERBIRD_LIBS_KWARGS_ARG_NUMS),$(if $(filter-out undefined,$(origin $n)),$n)))
$(eval __ALL_ARGS := $(strip $(foreach n,$(__DEFINED_ARGS),$($n) )))
$(eval __SPLIT_ARGS := $(subst $(__BOWERBIRD_LIBS_KWARGS_COMMA),$(__BOWERBIRD_LIBS_KWARGS_SPACE),$(__ALL_ARGS)))
# Error if too many arguments
$(if $(word $(__BOWERBIRD_LIBS_KWARGS_ARGS_LIMIT),$(__SPLIT_ARGS)),\
    $(error ERROR: Keyword argument limit reached (ARGS_LIMIT=$(__BOWERBIRD_LIBS_KWARGS_ARGS_LIMIT))))
# Parse each key=value pair and store as $(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).<key>
$(foreach arg,$(__SPLIT_ARGS),\
    $(if $(findstring =,$(arg)),\
        $(eval $(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).$(word 1,$(subst =, ,$(strip $(arg)))) := $(word 2,$(subst =, ,$(strip $(arg)))))\
    )\
)
endef

# bowerbird::lib::kwargs
#
#	Retrieves a keyword argument value.
#
#	Args:
#		$1: Key name
#
#	Returns:
#		The value of $(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).<key>
#
#	Example:
#		$(call bowerbird::lib::kwargs,name)
#
define bowerbird::lib::kwargs
$($(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).$1)
endef

# bowerbird::lib::kwargs-defined
#
#	Tests if a keyword argument is defined.
#
#	Args:
#		$1: Key name
#
#	Returns:
#		Non-empty if defined, empty otherwise
#
#	Example:
#		$(if $(call bowerbird::lib::kwargs-defined,branch),...)
#
define bowerbird::lib::kwargs-defined
$(filter-out undefined,$(origin $(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).$1))
endef

# bowerbird::lib::kwargs-default
#
#	Sets a default value for a keyword argument if not already defined.
#
#	Args:
#		$1: Key name
#		$2: Default value
#
#	Example:
#		$(call bowerbird::lib::kwargs-default,branch,main)
#
define bowerbird::lib::kwargs-default
$(if $(call bowerbird::lib::kwargs-defined,$1),,$(eval $(__BOWERBIRD_LIBS_KWARGS_VALUE_PREFIX).$1 := $2))
endef

# bowerbird::lib::kwargs-require
#
#	Validates that a required keyword argument is present.
#
#	Args:
#		$1: Key name
#		$2: Error message (optional, defaults to "ERROR: '$1' keyword is required")
#
#	Raises:
#		Error if the keyword argument is not defined or empty.
#
#	Example:
#		$(call bowerbird::lib::kwargs-require,name)
#		$(call bowerbird::lib::kwargs-require,name,'name' parameter is required)
#
define bowerbird::lib::kwargs-require
$(if $(call bowerbird::lib::kwargs,$1),,$(error $(if $2,$2,ERROR: '$1' keyword is required)))
endef
