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

require 'google/compute/property/array'
require 'puppet/property'

module Google
  module Compute
    module Data
      # A class to manage data for disks for instance.
      class InstanceDisks
        include Comparable

        attr_reader :auto_delete
        attr_reader :boot
        attr_reader :device_name
        attr_reader :disk_encryption_key
        attr_reader :index
        attr_reader :source
        attr_reader :initialize_params

        def to_json(_arg = nil)
          {
            'autoDelete' => auto_delete,
            'boot' => boot,
            'deviceName' => device_name,
            'diskEncryptionKey' => disk_encryption_key,
            'index' => index,
            'source' => source,
            'initializeParams' => initialize_params
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            auto_delete: auto_delete,
            boot: boot,
            device_name: device_name,
            disk_encryption_key: disk_encryption_key,
            index: index,
            source: source,
            initialize_params: initialize_params
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? InstanceDisks
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? InstanceDisks
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        private

        def compare_fields(other)
          [
            { self: auto_delete, other: other.auto_delete },
            { self: boot, other: other.boot },
            { self: device_name, other: other.device_name },
            { self: disk_encryption_key, other: other.disk_encryption_key },
            { self: index, other: other.index },
            { self: source, other: other.source },
            { self: initialize_params, other: other.initialize_params }
          ]
        end
      end

      # Manages a InstanceDisks nested object
      # Data is coming from the GCP API
      class InstanceDisksApi < InstanceDisks
        # rubocop:disable Metrics/MethodLength
        def initialize(args)
          @auto_delete =
            Google::Compute::Property::Boolean.api_munge(args['autoDelete'])
          @boot = Google::Compute::Property::Boolean.api_munge(args['boot'])
          @device_name =
            Google::Compute::Property::String.api_munge(args['deviceName'])
          @disk_encryption_key =
            Google::Compute::Property::InstaDiskEncryKey.api_munge(
              args['diskEncryptionKey']
            )
          @index = Google::Compute::Property::Integer.api_munge(args['index'])
          @source =
            Google::Compute::Property::DiskSelfLinkRef.api_munge(args['source'])
          @initialize_params =
            Google::Compute::Property::InstancInitialParams.api_munge(
              args['initializeParams']
            )
        end
        # rubocop:enable Metrics/MethodLength
      end

      # Manages a InstanceDisks nested object
      # Data is coming from the Puppet manifest
      class InstanceDisksCatalog < InstanceDisks
        # rubocop:disable Metrics/MethodLength
        def initialize(args)
          @auto_delete =
            Google::Compute::Property::Boolean.unsafe_munge(args['auto_delete'])
          @boot = Google::Compute::Property::Boolean.unsafe_munge(args['boot'])
          @device_name =
            Google::Compute::Property::String.unsafe_munge(args['device_name'])
          @disk_encryption_key =
            Google::Compute::Property::InstaDiskEncryKey.unsafe_munge(
              args['disk_encryption_key']
            )
          @index =
            Google::Compute::Property::Integer.unsafe_munge(args['index'])
          @source = Google::Compute::Property::DiskSelfLinkRef.unsafe_munge(
            args['source']
          )
          @initialize_params =
            Google::Compute::Property::InstancInitialParams.unsafe_munge(
              args['initialize_params']
            )
        end
        # rubocop:enable Metrics/MethodLength
      end
    end

    module Property
      # A class to manage input to disks for instance.
      class InstanceDisks < Puppet::Property
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::InstanceDisksCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::InstanceDisksApi.new(value)
        end
      end

      # A Puppet property that holds an integer
      class InstanceDisksArray < Google::Compute::Property::Array
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          return InstanceDisks.unsafe_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| InstanceDisks.unsafe_munge(v) }
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          return InstanceDisks.api_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| InstanceDisks.api_munge(v) }
        end
      end
    end
  end
end
