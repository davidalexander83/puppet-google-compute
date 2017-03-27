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

require 'spec_helper'
require 'uri'

class TestCred
  def authorize(request)
    request
  end
end

describe Google::Request::Post do
  let(:credential) { TestCred.new }
  let(:uri_in) { Google::NetworkBlocker::ALLOWED_TEST_URI }
  let(:uri_out) { URI.parse('https://somewhere.else.com/some/path') }
  let(:type_in) { 'application/myapp-request' }
  let(:type_out) { 'application/myapp-response' }
  let(:body_in) { { 'test1' => 'test' }.to_json }
  let(:body_out) { { field1: 'WORKS' }.to_json }

  context 'successful request' do
    before(:each) do
      Google::NetworkBlocker.instance.allow_post(
        uri_in: uri_in, type_in: type_in, body_in: body_in,
        code: 200, uri_out: uri_out, type_out: type_out, body_out: body_out
      )
    end

    subject { described_class.new(uri_in, credential, type_in, body_in).send }

    it { is_expected.to be_a_kind_of(Net::HTTPOK) }
    it { is_expected.to have_attributes(code: 200) }
    it { is_expected.to have_attributes(uri: uri_out) }
    it { is_expected.to have_attributes(content_type: type_out) }
    it { is_expected.to have_attributes(body: body_out) }
  end

  context 'failed request' do
    before(:each) { Google::NetworkBlocker.instance.deny(uri_in) }

    subject { described_class.new(uri_in, credential, type_in, body_in).send }

    it { is_expected.to be_a_kind_of(Net::HTTPNotFound) }
    it { is_expected.to have_attributes(code: 404) }
  end
end
