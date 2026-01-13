ifndef TEST_KWARGS_PARSE
TEST_KWARGS_PARSE := 1

test-kwargs-parse-basic:
	$(call bowerbird::lib::kwargs-parse,name=foo,path=bar)
	$(call bowerbird::test::compare-strings,$(call bowerbird::lib::kwargs,name),foo)
	$(call bowerbird::test::compare-strings,$(call bowerbird::lib::kwargs,path),bar)


test-kwargs-parse-with-spaces:
	$(call bowerbird::lib::kwargs-parse,name = foo , path = bar)
	$(call bowerbird::test::compare-strings,$(call bowerbird::lib::kwargs,name),foo)
	$(call bowerbird::test::compare-strings,$(call bowerbird::lib::kwargs,path),bar)


test-kwargs-default-provided:
	$(call bowerbird::lib::kwargs-parse,name=foo)
	$(call bowerbird::lib::kwargs-default,name,default)
	$(call bowerbird::test::compare-strings,$(call bowerbird::lib::kwargs,name),foo)


test-kwargs-default-not-provided:
	$(call bowerbird::lib::kwargs-parse,other=value)
	$(call bowerbird::lib::kwargs-default,name,default-value)
	$(call bowerbird::test::compare-strings,$(call bowerbird::lib::kwargs,name),default-value)


test-kwargs-require-provided:
	$(call bowerbird::lib::kwargs-parse,required=value)
	$(call bowerbird::lib::kwargs-require,required)
	$(call bowerbird::test::compare-strings,$(call bowerbird::lib::kwargs,required),value)


ifndef TEST_KWARGS_REQUIRE_MISSING
test-kwargs-require-missing: FORCE
	@$(MAKE) FORCE TEST_KWARGS_REQUIRE_MISSING=true $@ 2>&1 | \
		grep -q "ERROR: 'required' keyword is required" || \
		(>&2 echo "ERROR: Expected error message not found" && exit 1)
else
test-kwargs-require-missing:
	$(call bowerbird::lib::kwargs-parse,other=value)
	$(call bowerbird::lib::kwargs-require,required)
endif


ifndef TEST_KWARGS_REQUIRE_CUSTOM_ERROR
test-kwargs-require-custom-error: FORCE
	@$(MAKE) FORCE TEST_KWARGS_REQUIRE_CUSTOM_ERROR=true $@ 2>&1 | \
		grep -q "ERROR: Custom error message" || \
		(>&2 echo "ERROR: Expected custom error message not found" && exit 1)
else
test-kwargs-require-custom-error:
	$(call bowerbird::lib::kwargs-parse,other=value)
	$(call bowerbird::lib::kwargs-require,required,ERROR: Custom error message)
endif


test-kwargs-defined-true:
	$(call bowerbird::lib::kwargs-parse,name=foo)
	@test -n "$(call bowerbird::lib::kwargs-defined,name)" || \
		(>&2 echo "ERROR: Expected name to be defined" && exit 1)


test-kwargs-defined-false:
	$(call bowerbird::lib::kwargs-parse,other=value)
	@test -z "$(call bowerbird::lib::kwargs-defined,name)" || \
		(>&2 echo "ERROR: Expected name to be undefined" && exit 1)

endif
