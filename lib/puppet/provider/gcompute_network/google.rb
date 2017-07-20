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

require 'google/compute/network/delete'
require 'google/compute/network/get'
require 'google/compute/network/post'
require 'google/compute/network/put'
require 'google/compute/property/boolean'
require 'google/compute/property/integer'
require 'google/compute/property/string'
require 'google/compute/property/string_array'
require 'google/compute/property/time'
require 'google/hash_utils'
require 'google/object_store'
require 'puppet'

Puppet::Type.type(:gcompute_network).provide(:google) do
  mk_resource_methods

  def self.instances
    debug('instances')
    raise [
      '"puppet resource" is not supported at the moment:',
      'TODO(nelsonjr): https://goto.google.com/graphite-bugs-view?id=167'
    ].join(' ')
  end

  def self.prefetch(resources)
    debug('prefetch')
    resources.each do |name, resource|
      project = resource[:project]
      debug("prefetch #{name}") if project.nil?
      debug("prefetch #{name} @ #{project}") unless project.nil?
      fetch = fetch_resource(resource, self_link(resource), 'compute#network')
      resource.provider = present(name, fetch) unless fetch.nil?
      Google::ObjectStore.instance.add(:gcompute_network, resource)
    end
  end

  def self.present(name, fetch)
    result = new({ title: name, ensure: :present }.merge(fetch_to_hash(fetch)))
    result.instance_variable_set(:@fetched, fetch)
    result
  end

  # rubocop:disable Metrics/MethodLength
  def self.fetch_to_hash(fetch)
    {
      description:
        Google::Compute::Property::String.api_munge(fetch['description']),
      gateway_ipv4:
        Google::Compute::Property::String.api_munge(fetch['gatewayIPv4']),
      id: Google::Compute::Property::Integer.api_munge(fetch['id']),
      ipv4_range:
        Google::Compute::Property::String.api_munge(fetch['IPv4Range']),
      name: Google::Compute::Property::String.api_munge(fetch['name']),
      subnetworks:
        Google::Compute::Property::StringArray.api_munge(fetch['subnetworks']),
      auto_create_subnetworks: Google::Compute::Property::Boolean.api_munge(
        fetch['autoCreateSubnetworks']
      ),
      creation_timestamp:
        Google::Compute::Property::Time.api_munge(fetch['creationTimestamp'])
    }.reject { |_, v| v.nil? }
  end
  # rubocop:enable Metrics/MethodLength

  def exists?
    debug("exists? #{@property_hash[:ensure] == :present}")
    @property_hash[:ensure] == :present
  end

  def create
    debug('create')
    @created = true
    create_req = Google::Compute::Network::Post.new(collection(@resource),
                                                    fetch_auth(@resource),
                                                    'application/json',
                                                    resource_to_request)
    @fetched = wait_for_operation create_req.send, @resource
    @property_hash[:ensure] = :present
  end

  def destroy
    debug('destroy')
    @deleted = true
    delete_req = Google::Compute::Network::Delete.new(self_link(@resource),
                                                      fetch_auth(@resource))
    wait_for_operation delete_req.send, @resource
    @property_hash[:ensure] = :absent
  end

  def flush
    debug('flush')
    # return on !@dirty is for aiding testing (puppet already guarantees that)
    return if @created || @deleted || !@dirty
    unless @dirty.keys == [:auto_create_subnetworks]
      raise ['Network specification mismatch and cannot be edited.',
             'The only allowed change is from Auto to Custom type.'].join(' ')
    end
    handle_auto_to_custom_change
  end

  def dirty(field, from, to)
    @dirty = {} if @dirty.nil?
    @dirty[field] = {
      from: from,
      to: to
    }
  end

  def exports
    {
      self_link: @fetched['selfLink']
    }
  end

  private

  # Hashes have :true or :false which to_json converts to strings
  def sym_to_bool(value)
    if value == :true
      true
    elsif value == :false
      false
    else
      value
    end
  end

  def self.resource_to_hash(resource)
    {
      project: resource[:project],
      name: resource[:name],
      kind: 'compute#network',
      description: resource[:description],
      gateway_ipv4: resource[:gateway_ipv4],
      id: resource[:id],
      ipv4_range: resource[:ipv4_range],
      subnetworks: resource[:subnetworks],
      auto_create_subnetworks: resource[:auto_create_subnetworks],
      creation_timestamp: resource[:creation_timestamp]
    }.reject { |_, v| v.nil? }
  end

  def resource_to_request
    request = {
      kind: 'compute#network',
      description: @resource[:description],
      gatewayIPv4: @resource[:gateway_ipv4],
      IPv4Range: @resource[:ipv4_range],
      name: @resource[:name],
      autoCreateSubnetworks: @resource[:auto_create_subnetworks]
    }.reject { |_, v| v.nil? }

    # Convert boolean symbols into JSON compatible value.
    request = request.inject({}) { |h, (k, v)| h.merge(k => sym_to_bool(v)) }

    debug "request: #{request}" unless ENV['PUPPET_HTTP_DEBUG'].nil?
    request.to_json
  end

  def fetch_auth(resource)
    self.class.fetch_auth(resource)
  end

  def self.fetch_auth(resource)
    Puppet::Type.type(:gauth_credential).fetch(resource)
  end

  def debug(message)
    puts("DEBUG: #{message}") if ENV['PUPPET_HTTP_VERBOSE']
    super(message)
  end

  def self.collection(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/global/networks',
        data
      )
    )
  end

  def collection(data)
    self.class.collection(data)
  end

  def self.self_link(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/global/networks/{{name}}',
        data
      )
    )
  end

  def self_link(data)
    self.class.self_link(data)
  end

  def self.return_if_object(response, kind)
    raise "Bad response: #{response}" \
      unless response.is_a?(Net::HTTPResponse)
    return if response.is_a?(Net::HTTPNotFound)
    return if response.is_a?(Net::HTTPNoContent)
    result = JSON.parse(response.body)
    raise_if_errors result, %w[error errors], 'message'
    raise "Bad response: #{response}" unless response.is_a?(Net::HTTPOK)
    raise "Incorrect result: #{result['kind']} (expected '#{kind}')" \
      unless result['kind'] == kind
    result
  end

  def return_if_object(response, kind)
    self.class.return_if_object(response, kind)
  end

  def self.extract_variables(template)
    template.scan(/{{[^}]*}}/).map { |v| v.gsub(/{{([^}]*)}}/, '\1') }
            .map(&:to_sym)
  end

  def self.expand_variables(template, var_data, extra_data = {})
    data = if var_data.class <= Hash
             var_data.merge(extra_data)
           else
             resource_to_hash(var_data).merge(extra_data)
           end
    extract_variables(template).each do |v|
      unless data.key?(v)
        raise "Missing variable :#{v} in #{data} on #{caller.join("\n")}}"
      end
      template.gsub!(/{{#{v}}}/, CGI.escape(data[v].to_s))
    end
    template
  end

  def expand_variables(template, var_data, extra_data = {})
    self.class.expand_variables(template, var_data, extra_data)
  end

  def fetch_resource(resource, self_link, kind)
    self.class.fetch_resource(resource, self_link, kind)
  end

  def async_op_url(data, extra_data = {})
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/global/operations/{{op_id}}',
        data, extra_data
      )
    )
  end

  def wait_for_operation(response, resource)
    op_result = return_if_object(response, 'compute#operation')
    return if op_result.nil?
    status = ::Google::HashUtils.navigate(op_result, %w[status])
    fetch_resource(
      resource,
      URI.parse(::Google::HashUtils.navigate(wait_for_completion(status,
                                                                 op_result,
                                                                 resource),
                                             %w[targetLink])),
      'compute#network'
    )
  end

  def wait_for_completion(status, op_result, resource)
    op_id = ::Google::HashUtils.navigate(op_result, %w[name])
    op_uri = async_op_url(resource, op_id: op_id)
    while status != 'DONE'
      debug("Waiting for completion of operation #{op_id}")
      raise_if_errors op_result, %w[error errors], 'message'
      sleep 1.0
      raise "Invalid result '#{status}' on gcompute_network." \
        unless %w[PENDING RUNNING DONE].include?(status)
      op_result = fetch_resource(resource, op_uri, 'compute#operation')
      status = ::Google::HashUtils.navigate(op_result, %w[status])
    end
    op_result
  end

  def raise_if_errors(response, err_path, msg_field)
    self.class.raise_if_errors(response, err_path, msg_field)
  end

  def handle_auto_to_custom_change
    # We allow changing the auto_create_subnetworks from true => false
    # (which will make the network going from Auto to Custom)
    auto_change = @dirty[:auto_create_subnetworks]
    raise 'Cannot convert a network from Custom back to Auto' \
      if auto_change[:from] == false && auto_change[:to] == true
    # TODO(nelsonjr): Enable converting from Auto => Custom via call to
    # special method URL. See tracking work item:
    # https://bugzilla.graphite.cloudnativeapp.com/show_bug.cgi?id=174
    raise [
      'Conversion from Auto to Custom not implemented yet.',
      'See', ['https://bugzilla.graphite.cloudnativeapp.com',
              'show_bug.cgi?id=174'].join('/'),
      'for more details'
    ].join(' ')
  end

  def self.fetch_resource(resource, self_link, kind)
    get_request = ::Google::Compute::Network::Get.new(
      self_link, fetch_auth(resource)
    )
    return_if_object get_request.send, kind
  end

  def self.raise_if_errors(response, err_path, msg_field)
    errors = ::Google::HashUtils.navigate(response, err_path)
    raise_error(errors, msg_field) unless errors.nil?
  end

  def self.raise_error(errors, msg_field)
    raise IOError, ['Operation failed:',
                    errors.map { |e| e[msg_field] }.join(', ')].join(' ')
  end
end
