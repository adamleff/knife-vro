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

module KnifeVro
  module WorkflowBase
    def self.included(includer)
      includer.class_eval do
        deps do
          require 'vcoworkflows'
        end

        option :vro_api_url, 
          long:        '--vro-api-url API_URL',
          description: 'URL for the vRO API'

        option :vro_username,
          long:        '--vro-username USERNAME',
          description: 'Username to use with the vRO API'

        option :vro_password,
          long:        '--vro-password PASSWORD',
          description: 'Password to use with the vRO API'

        option :vro_disable_ssl_verify,
          long:        '--vro-disable-ssl-verify',
          description: 'Skip any SSL verification for the vRO API',
          boolean:     true,
          default:     false
      end

      def get_config_value(key)
        key = key.to_sym
        config[key] || Chef::Config[:knife][key]
      end

      def verify_ssl
        ! get_config_value(:vro_disable_ssl_verify)
      end

      def conn_config
        @conn_config ||= VcoWorkflows::Config.new(
          url:        get_config_value(:vro_api_url),
          username:   get_config_value(:vro_username),
          password:   get_config_value(:vro_password),
          verify_ssl: verify_ssl
        )
      end

      def validate!(additional_opts=[])
        additional_opts = [additional_opts] unless additional_opts.is_a?(Array)

        required_opts = [ :vro_api_url, :vro_username, :vro_password ] + additional_opts
        missing_opts  = Array.new

        required_opts.each do |opt|
          if get_config_value(opt).nil?
            missing_opts << opt
          end
        end

        if missing_opts.length > 0
          ui.error("The following config options are required: #{missing_opts.join(', ')}")
          exit 1
        end
      end
    end
  end
end
