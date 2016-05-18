#
# Cookbook Name:: mongotest
# Recipe:: test_mongos
#
# Copyright (C) 2016 Parallels IP Holdings GmbH
#
# All rights reserved - Do Not Redistribute
#

app_info = data_bag_item('keys', 'sharding')

include_recipe 'mongodb3-objects::default'
node.set['mongodb3']['config']['mongos']['sharding']['configDB'] = app_info['config_relset'] + '/' + (app_info['config_servers']).join(',')
node.set['mongodb3']['config']['mongos']['net']['port'] = 27_017
include_recipe 'mongodb3::mongos'

app_info['shards'].each do |shard|
  mongodb_shard "#{shard}:27018"
end

mongodb_sharding_database app_info['sharding_database']

mongodb_sharding_collection app_info['sharding_collection'] do
  shard_key('_id' => 1)
end
