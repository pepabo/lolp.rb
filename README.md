# Lolp.rb

Simple ruby wrapper for Lolipop! API.

[![Gem Version](https://badge.fury.io/rb/lolp.svg)](https://badge.fury.io/rb/lolp)
[![Build Status](https://travis-ci.org/pepabo/lolp.rb.svg?branch=master)](https://travis-ci.org/pepabo/lolp.rb)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lolp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lolp

## Usage

```ruby
Lolp.configure do |config|
  config.api_endpoint = 'LOLIPOP MC API ENDPOINT'
  config.username     = 'LOLIPOP MC USERNAME'
  config.password     = 'LOLIPOP MC PASSWORD'
end
```

### Projects

```ruby
Lolp.projects
Lolp.create_project(:rails) # :wordpress, :php, ...
Lolp.delete_project('jungly-naha-2778')
Lolp.create_custom_domain('jungly-naha-2778.lolipop.ohr','example.com')
Lolp.delete_custom_domain('jungly-naha-2778.lolipop.ohr','example.com')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing


Bug reports and pull requests are welcome on GitHub at https://github.com/pepabo/lolp.
