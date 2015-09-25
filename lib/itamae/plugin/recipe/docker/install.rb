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

when 'redhat' # and CentOS
  execute 'yum update -y' do
    not_if 'which docker'
  end

  remote_file '/etc/yum.repos.d/docker.repo' do
    source 'files/docker.repo'
  end

  package 'docker-engine'

else
  raise node[:platform]
end

service 'docker' do
  action [:enable, :start]
end
