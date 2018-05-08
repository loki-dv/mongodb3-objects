#
# Cookbook Name:: mongotest
# Recipe:: test_cfg
#
# Copyright:: 2016-2017 Parallels International GmbH
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

app_info = data_bag_item('keys', 'sharding')

node.default['mongodb3']['config']['mongod']['sharding']['clusterRole'] = 'configsvr'
node.default['mongodb3']['config']['mongod']['net']['port'] = 27_019
node.default['mongodb3']['config']['mongod']['replication']['replSetName'] = app_info['config_relset']

include_recipe 'mongodb3-objects::default'
include_recipe 'mongodb3::package_repo'
include_recipe 'mongodb3::default'

service 'mongod' do
  supports start: true, stop: true, restart: true, status: true
  action [:enable, :start]
end
