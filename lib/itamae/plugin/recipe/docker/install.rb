# All steps are interpretation of:
# https://docs.docker.com/installation

case node[:platform]
when 'arch'
  execute 'pacman -Syy' do
    not_if 'which docker'
  end

  package 'bridge-utils'
  package 'device-mapper'
  package 'iproute2'
  package 'lxc'
  package 'sqlite'

  package 'docker'

when 'darwin'
  begin
    require 'itamae/plugin/resource/cask'
  rescue LoadError
    abort '"itamae-plugin-resource-cask" gem is required for darwin. Please add it to Gemfile or gem install it.'
  end

  execute '/usr/local/bin/brew update' do
    not_if 'which docker'
  end

  cask 'dockertoolbox'

when 'debian'
  execute 'echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list' do
    not_if 'cat /etc/apt/sources.list | grep wheezy-backports'
  end

  execute 'apt-get install linux-image-amd64 -t wheezy-backports && reboot' do
    not_if 'dpkg -l | grep -q linux-image-amd64'
  end

  execute 'curl -sSL https://get.docker.com/ | sh' do
    not_if 'which docker'
  end

when 'fedora', 'redhat' # and centos
  execute 'yum update -y' do
    not_if 'which docker'
  end

  remote_file '/etc/yum.repos.d/docker.repo' do
    source 'files/docker.repo'
  end

  package 'docker-engine'

when 'gentoo'
  execute 'emerge -av app-emulation/docker' do
    not_if 'which docker'
  end

when 'ubuntu'
  execute 'apt-get install linux-image-generic-lts-trusty && reboot' do
    only_if 'cat /etc/lsb_release | grep -q DISTRIB_RELEASE=12 && dpkg -l | ! (grep -q linux-image-generic-lts-trusty)'
  end

  execute 'apt-get update' do
    not_if 'which docker'
  end

  package 'curl'
  execute 'curl -sSL https://get.docker.com/ | sh' do
    not_if 'which docker'
  end

else
  require 'itamae/plugin/recipe/version'
  abort "'#{node[:platform]}' is not supported by v#{Itamae::Plugin::Recipe::Docker::VERSION} of itamae-plugin-recipe-docker."
end

if node[:platform] != 'darwin'
  service 'docker' do
    action [:enable, :start]
  end
end

if node.dig('docker', 'users')
  node['docker']['users'].each do |user|
    execute "usermod -aG docker #{user}" do
      not_if "groups #{user} | grep docker -w"
    end
  end
end
