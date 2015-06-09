#
# Author:: Adam Leff (<aleff@chef.io>)
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
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
#

require 'spec_helper'

class WorkflowBaseTester < Chef::Knife
  include KnifeVro::WorkflowBase
end

WorkflowBaseTester.load_deps

describe KnifeVro::WorkflowBase do
  let(:username)          { 'myuser' }
  let(:password)          { 'mypassword' }
  let(:api_url)           { 'https://vco.fake' }
  let(:username_override) { 'user-override'}

  before(:each) do
    @knife = WorkflowBaseTester.new

    Chef::Config[:knife][:vro_username] = username
    Chef::Config[:knife][:vro_password] = password
    Chef::Config[:knife][:vro_api_url]  = api_url
  end

  it '#conn_config returns a valid config object' do
    expect(@knife.conn_config.username).to eq(username)
    expect(@knife.conn_config.password).to eq(password)
    expect(@knife.conn_config.url).to eq(api_url + '/vco/api')
  end

  it '#get_config_value returns values from knife.rb' do
    expect(@knife.get_config_value(:vro_username)).to eq(username)
  end

  it '#get_config_value allows CLI options to override knife.rb' do
    @knife.config[:vro_username] = username_override
    expect(@knife.get_config_value(:vro_username)).to eq(username_override)
  end

  it '#verify_ssl SSL verification enabled by default' do
    expect(@knife.verify_ssl).to eq(true)
  end

  it '#verify_ssl SSL verification can be disabled' do
    @knife.config[:vro_disable_ssl_verify] = true
    expect(@knife.verify_ssl).to eq(false)
  end

  it '#verify_ssl SSL verification can be forced enabled' do
    @knife.config[:vro_disable_ssl_verify] = false
    expect(@knife.verify_ssl).to eq(true)
  end

  it '#validate! does not raise an exception' do
    expect { @knife.validate! }.not_to raise_error
  end

  it '#validate! raises an exception if a required param is missing' do
    Chef::Config[:knife][:vro_username] = nil
    expect { @knife.validate! }.to raise_error
  end

  it '#validate! allows validation of additional required params - params supplied' do
    @knife.config[:another_param] = true
    expect { @knife.validate!(:another_param) }.not_to raise_error
  end

  it '#validate! allows validation of additional required params - params not supplied' do
    expect { @knife.validate!(:another_param) }.to raise_error
  end
end
