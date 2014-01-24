#
# Cookbook Name:: droonga
# Recipe:: user
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

droonga_engine = node["droonga"]["engine"]

user_name  = droonga["user_name"]
group_name = droonga["group_name"]
home_dir   = droonga["home"]

user user_name do
  home     home_dir
  group    group_name
  password nil
  supports :manage_home => true
end
