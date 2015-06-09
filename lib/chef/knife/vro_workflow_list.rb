require 'chef/knife'

module KnifeVro
  class VroWorkflowList < Chef::Knife
    include KnifeVro::WorkflowBase

    banner 'knife vro workflow list'

    def run
      validate!
      puts conn_config.inspect
    end
  end
end
