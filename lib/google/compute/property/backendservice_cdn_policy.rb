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

require 'puppet/property'

module Google
  module Compute
    module Data
      # A class to manage data for cdn_policy for backend_service.
      class BackeServiCdnPolic
        include Comparable

        attr_reader :cache_key_policy

        def to_json(_arg = nil)
          {
            'cacheKeyPolicy' => cache_key_policy
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            cache_key_policy: cache_key_policy
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? BackeServiCdnPolic
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? BackeServiCdnPolic
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
            { self: cache_key_policy, other: other.cache_key_policy }
          ]
        end
      end

      # Manages a BackeServiCdnPolic nested object
      # Data is coming from the GCP API
      class BackeServiCdnPolicApi < BackeServiCdnPolic
        def initialize(args)
          @cache_key_policy =
            Google::Compute::Property::BackServCachKeyPoli.api_munge(
              args['cacheKeyPolicy']
            )
        end
      end

      # Manages a BackeServiCdnPolic nested object
      # Data is coming from the Puppet manifest
      class BackeServiCdnPolicCatalog < BackeServiCdnPolic
        def initialize(args)
          @cache_key_policy =
            Google::Compute::Property::BackServCachKeyPoli.unsafe_munge(
              args['cache_key_policy']
            )
        end
      end
    end

    module Property
      # A class to manage input to cdn_policy for backend_service.
      class BackeServiCdnPolic < Puppet::Property
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::BackeServiCdnPolicCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::BackeServiCdnPolicApi.new(value)
        end
      end
    end
  end
end
