# Suppress warnings for this block
original_verbose = $VERBOSE
$VERBOSE = nil

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

# Restore the original value of $VERBOSE
$VERBOSE = original_verbose
