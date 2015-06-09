require 'chef/knife'
require 'chef/knife/vro_workflow_base'
require 'chef/knife/vro_workflow_list'

RSpec.configure do |c|
  c.before(:each) do
    Chef::Config.reset
  end
end
