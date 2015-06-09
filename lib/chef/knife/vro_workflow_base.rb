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
