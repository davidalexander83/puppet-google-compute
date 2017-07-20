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

require 'spec_helper'

describe Puppet::Type.type(:gcompute_license).provider(:google) do
  before(:all) do
    cred = Google::FakeAuthorization.new
    Puppet::Type.type(:gauth_credential)
                .define_singleton_method(:fetch) { |_resource| cred }
  end

  it '#instances' do
    expect { described_class.instances }.to raise_error(StandardError,
                                                        /not supported/)
  end

  context 'resource exists' do
    # Ensure ignore: resource exists, no change
    context 'no changes == no action' do
      # Ensure ignore: resource exists, no change, no name, pass
      context 'title == name (pass)' do
        # TODO(nelsonjr): Implement new test format.
      end

      # Ensure ignore: resource exists, no change, has name, pass
      context 'title != name (pass)' do
        # TODO(nelsonjr): Implement new test format.
      end
    end

    # Ensure ignore: resource exists, changes
    context 'changes == action' do
      # Ensure ignore: resource exists, changes, no name, fail
      context 'title == name (fail)' do
        # TODO(nelsonjr): Implement new test format.
        subject { -> { raise '[placeholder] This should fail.' } }
        it { is_expected.to raise_error(RuntimeError, /placeholder/) }
      end

      # Ensure ignore: resource exists, changes, has name, fail
      context 'title != name (fail)' do
        # TODO(nelsonjr): Implement new test format.
        subject { -> { raise '[placeholder] This should fail.' } }
        it { is_expected.to raise_error(RuntimeError, /placeholder/) }
      end
    end
  end

  context 'resource missing' do
    # Ensure ignore: resource missing, ignore, no name, fail
    context 'title == name (fail)' do
      # TODO(nelsonjr): Implement new test format.
      subject { -> { raise '[placeholder] This should fail.' } }
      it { is_expected.to raise_error(RuntimeError, /placeholder/) }
    end

    # Ensure ignore: resource missing, ignore, has name, fail
    context 'title != name (fail)' do
      # TODO(nelsonjr): Implement new test format.
      subject { -> { raise '[placeholder] This should fail.' } }
      it { is_expected.to raise_error(RuntimeError, /placeholder/) }
    end
  end

  context '#flush' do
    subject do
      Puppet::Type.type(:gcompute_license).new(
        name: 'my-name'
      ).provider
    end
    context 'no-op' do
      it { subject.flush }
    end
    context 'modified object' do
      before do
        subject.dirty :some_property, 'current', 'newvalue'
      end
      context 'no-op if created' do
        before { subject.instance_variable_set(:@created, true) }
        it { expect { subject.flush }.not_to raise_error }
      end
      context 'no-op if deleted' do
        before { subject.instance_variable_set(:@deleted, true) }
        it { expect { subject.flush }.not_to raise_error }
      end
    end
  end

  private

  def expect_network_get_success(id, data = {})
    id_data = data.fetch(:name, '').include?('title') ? 'title' : 'name'
    body = load_network_result("success#{id}~#{id_data}.yaml").to_json

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    debug_network "!! GET #{self_link(uri_data(id).merge(data))}"
    expect(Google::Compute::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug_network ">> GET #{args}"
      request
    end
  end

  def http_success(body)
    response = Net::HTTPOK.new(1.0, 200, 'OK')
    response.body = body
    response.instance_variable_set(:@read, true)
    response
  end

  def expect_network_get_failed(id, data = {})
    request = double('request')
    allow(request).to receive(:send).and_return(http_failed_object_missing)

    debug_network "!! #{self_link(uri_data(id).merge(data))}"
    expect(Google::Compute::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug_network ">> GET [failed] #{args}"
      request
    end
  end

  def http_failed_object_missing
    Net::HTTPNotFound.new(1.0, 404, 'Not Found')
  end

  def load_network_result(file)
    results = File.join(File.dirname(__FILE__), 'data', 'network',
                        'gcompute_license', file)
    debug("Loading result file: #{results}")
    raise "Network result data file #{results}" unless File.exist?(results)
    data = YAML.safe_load(File.read(results))
    raise "Invalid network results #{results}" unless data.class <= Hash
    data
  end

  def debug(message)
    puts(message) if ENV['RSPEC_DEBUG']
  end

  def debug_network(message)
    puts("Network #{message}") \
      if ENV['RSPEC_DEBUG'] || ENV['RSPEC_HTTP_VERBOSE']
  end

  def create_type(id)
    Puppet::Type.type(:gcompute_license).new(
      title: "title#{id - 1}",
      credential: "cred#{id - 1}",
      project: GoogleTests::Constants::L_PROJECT_DATA[(id - 1) \
        % GoogleTests::Constants::L_PROJECT_DATA.size],
      name: GoogleTests::Constants::L_NAME_DATA[(id - 1) \
        % GoogleTests::Constants::L_NAME_DATA.size]
    )
  end

  def expand_variables(template, data, extra_data = {})
    Puppet::Type.type(:gcompute_license).provider(:google)
                .expand_variables(template, data, extra_data)
  end

  def collection(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        '/projects/{{project}}/global/licenses',
        data
      )
    )
  end

  def self_link(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        '/projects/{{project}}/global/licenses/{{name}}',
        data
      )
    )
  end

  # Creates variable test data to comply with self_link URI parameters
  def uri_data(id)
    {
      project: GoogleTests::Constants::L_PROJECT_DATA[(id - 1) \
        % GoogleTests::Constants::L_PROJECT_DATA.size],
      name: GoogleTests::Constants::L_NAME_DATA[(id - 1) \
        % GoogleTests::Constants::L_NAME_DATA.size]
    }
  end
end
