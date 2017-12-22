rubylib = (ENV["RUBYLIB"] || "").split(File::PATH_SEPARATOR)
rubylib.unshift %|#{File.dirname(__FILE__) + '/../../lib'}|
ENV["RUBYLIB"] = rubylib.uniq.join(File::PATH_SEPARATOR)
require 'rubygems'
require 'aruba/config'
require 'aruba/cucumber'
require 'fileutils'
require 'pathname'
require 'rspec/expectations'
require 'hiera/backend/eyaml/parser/parser.rb'
require 'hiera/backend/eyaml/options'
require 'hiera/backend/eyaml/parser/encrypted_tokens'

Before do
  # set to a non-existant home in order so rogue configs don't confuse
  ENV['SANDBOX_HOME'] = 'clean_home'
  ENV['EYAML_CONFIG'] = nil
  @aruba_timeout_seconds = 30
end
