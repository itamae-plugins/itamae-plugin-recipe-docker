# Itamae::Plugin::Recipe::Docker

[Itamae](https://github.com/itamae-kitchen/itamae) plugin to install Docker
in the way described in https://docs.docker.com/installation.

## Supported Platforms

- Arch Linux

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
include_recipe "docker::install"
```

## License

MIT License
