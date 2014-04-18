#
# Cookbook Name:: droonga
# Recipe:: engine
#
# Copyright 2014, Kouhei Sutou
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

include_recipe "build-essential"
include_recipe "git"
include_recipe "groonga::development"

droonga_engine = node.droonga.engine

user_name  = droonga_engine.user_name
group_name = droonga_engine.group_name
home_dir   = droonga_engine.home
ruby       = droonga_engine.ruby

service_name = "droonga-engine"

group group_name do
end

user user_name do
  home     home_dir
  group    group_name
  password nil
  supports :manage_home => true
end

package "ruby-dev" do
  action :install
end

gem_package "bundler" do
  action :install
end

deploy "#{home_dir}/droonga-engine" do
  repo "https://github.com/droonga/droonga-engine"
  user user_name
  group group_name
  shallow_clone
  keep_releases 10
  purge_before_symlink ["log", "tmp/pids"]
  create_dirs_before_symlink ["tmp"]
  symlink_before_migrate "config" => "config"
  symlinks "pids" => "tmp/pids",
           "log" => "log"
  action :deploy

  migrate true
  migration_command "bundle install --path vendor/bundle --shebang $(which ruby)"

  before_migrate do
    log_dir = "#{new_resource.shared_path}/log"
    directory log_dir do
      user user_name
      group group_name
      mode 0755
    end

    config_dir = "#{new_resource.shared_path}/config"
    directory config_dir do
      user user_name
      group group_name
      mode 0755
    end

    template "#{config_dir}/fluentd.conf" do
      source "droonga-engine-fluentd.conf.erb"
      cookbook droonga_engine.template.cookbooks["fluentd.conf"]
      user user_name
      group group_name
      mode 0644
    end

    template "#{config_dir}/catalog.json" do
      source "droonga-engine-catalog.json.erb"
      cookbook droonga_engine.template.cookbooks["catalog.json"]
      user user_name
      group group_name
      mode 0644
    end
  end

  notifies :restart, "runit_service[#{service_name}]"
end

package "runit" do
end

runit_service service_name do
  log true
  default_logger true
end

log_dir = "/var/log/#{service_name}"
log_config = "#{log_dir}/config"
template log_config do
  source "sv-droonga-engine-log-config.erb"
  mode 0644
end
