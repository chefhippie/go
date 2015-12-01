#
# Cookbook Name:: go
# Attributes:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
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

default["go"]["method"] = "package"

case node["platform_family"]
when "suse"
  repo = case node["platform_version"]
  when /\A13\.\d+\z/
    "openSUSE_#{node["platform_version"]}"
  when /\A42\.\d+\z/
    "openSUSE_Leap_#{node["platform_version"]}"
  when /\A\d{8}\z/
    "openSUSE_Tumbleweed"
  else
    raise "Unsupported SUSE version"
  end

  default["go"]["zypper"]["enabled"] = true
  default["go"]["zypper"]["alias"] = "go"
  default["go"]["zypper"]["title"] = "Go"
  default["go"]["zypper"]["repo"] = "http://download.opensuse.org/repositories/devel:/languages:/go/#{repo}/"
  default["go"]["zypper"]["key"] = "#{node["go"]["zypper"]["repo"]}repodata/repomd.xml.key"
end
