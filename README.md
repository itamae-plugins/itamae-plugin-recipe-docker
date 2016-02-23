# Itamae::Plugin::Recipe::Docker

[Itamae](https://github.com/itamae-kitchen/itamae) plugin to install Docker
in the way described in https://docs.docker.com/installation.

## Supported Platforms

- Arch Linux
- CentOS
- Debian
- Fedora
- Gentoo
- OSX
- Red Hat Enterprise Linux
- Ubuntu

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-docker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-docker

## Usage

Write a following line to your itamae recipe.

```rb
# recipe.rb

# Install Docker, start it and ensure it starts on boot.
include_recipe "docker::install"
```

Execute it with: `itamae ssh -h ... recipe.rb`.

If you want to add users to docker group, configure your node.yml as:

```yml
# node.yml
docker:
  # Users who is added to docker group (optional)
  users:
    - k0kubun
```

Execute it with: `itamae ssh -h ... -y node.yml recipe.rb`

NOTE: Some versions of **Debian and Ubuntu reboot**.  
And you should apply the recipe again after the reboot.

## License

MIT License
