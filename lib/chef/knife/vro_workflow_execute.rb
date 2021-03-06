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

require 'chef/knife'

module KnifeVro
  class VroWorkflowExecute < Chef::Knife

    banner 'knife vro workflow execute'

    option :async, 
      long:        '--async',
      description: 'Perform the vRO workflow execution asynchronously - do not wait for output',
      boolean:     true,
      default:     false

    def run
    end
  end
end
