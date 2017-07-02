# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by puppet-codegen and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

#----------------------------------------------------------
# Setup timezone.
#
# Our default timezone is UTC, to avoid local time compromise
# test code seed generation.

ENV['TZ'] = 'UTC'

#----------------------------------------------------------
# Setup code coverage

require 'simplecov'
SimpleCov.start

#----------------------------------------------------------
# Add test path to the search libs

$LOAD_PATH.unshift(File.expand_path('.'))

#----------------------------------------------------------
# Block all network traffic

require 'network_blocker'

#----------------------------------------------------------
# Auto require files

files = []
files << 'spec/bundle.rb'
files << 'spec/copyright.rb'
files << 'spec/fake_auth.rb'
files << 'spec/test_constants.rb'
files << File.join('lib', '**', '*.rb')

# Require all files so we can track them via code coverage
Dir[*files].reject { |p| File.directory? p }
           .each do |f|
             puts "Auto requiring #{f}" \
               if ENV['RSPEC_DEBUG']
             require f
           end

#----------------------------------------------------------
# Setup PuppetSpec to allow executing the Puppet manifests from within tests

require 'puppet'

module PuppetSpec
  puppet_dir = File.dirname(Puppet.method(:settings).source_location[0])
  require File.join(puppet_dir, '../spec/lib/puppet_spec/compiler')
  require File.join(puppet_dir, '../spec/lib/puppet_spec/files')
end

require 'rspec-puppet'

RSpec.configure do |c|
  c.include PuppetSpec::Compiler
  c.include PuppetSpec::Files

  Puppet::Test::TestHelper.initialize

  c.before :all do
    Puppet::Test::TestHelper.before_all_tests
  end

  c.after :all do
    Puppet::Test::TestHelper.after_all_tests
  end

  c.before :each do
    base = PuppetSpec::Files.tmpdir('tmp_settings')
    Puppet[:vardir] = File.join(base, 'var')
    Puppet[:confdir] = File.join(base, 'etc')
    Puppet[:codedir] = File.join(base, 'code')
    Puppet[:logdir] = '$vardir/log'
    Puppet[:rundir] = '$vardir/run'
    Puppet[:hiera_config] = File.join(base, 'hiera')

    FileUtils.mkdir_p Puppet[:statedir]

    Puppet::Test::TestHelper.before_each_test
  end

  c.after :each do
    Puppet::Test::TestHelper.after_each_test
    Dir.stub(:entries)
    PuppetSpec::Files.cleanup
  end
end

#----------------------------------------------------------
# Helper modules

require 'yaml'
