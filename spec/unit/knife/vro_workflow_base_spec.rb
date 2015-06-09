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

  it '#conn_config allows overriding via CLI options' do
    @knife.config[:vro_username] = username_override
    expect(@knife.conn_config.username).to eq(username_override)
  end
end
