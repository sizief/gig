$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "githubgrab"
require 'fileutils'
require "minitest/autorun"
require 'webmock/test_unit'

Minitest.after_run { 
    FileUtils.rm_rf(Dir.glob('./test/tmp/topic*'))
 }
