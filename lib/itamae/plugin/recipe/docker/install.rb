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

when 'debian'
  execute 'echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list' do
    not_if 'cat /etc/apt/sources.list | grep wheezy-backports'
  end

  execute 'apt-get install linux-image-amd64 -t wheezy-backports && reboot' do
    not_if 'dpkg -l | grep -q linux-image-amd64'
  end

  execute 'apt-get update' do
    not_if 'which docker'
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
  raise node[:platform]
end

service 'docker' do
  action [:enable, :start]
end
