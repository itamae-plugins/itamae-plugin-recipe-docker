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
end

package 'docker'
