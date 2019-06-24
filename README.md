<p align="center"><img src="https://raw.githubusercontent.com/pepabo/lolp.rb/images/lolipop-logo-by-gmo-pepabo.png" width="300" alt="lolp" /></p><p align="center"><strong>lolp</strong>: Simple ruby wrapper for Lolipop! API.</p> <br /> <br />

[![Gem Version](https://img.shields.io/gem/v/lolp.svg?style=flat-square)](https://rubygems.org/gems/lolp)
[![Build Status](https://img.shields.io/travis/pepabo/lolp.rb.svg?style=flat-square)](https://travis-ci.org/pepabo/lolp.rb)

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
Lolp.create_project(:rails, db_password: 'db_password') # :wordpress, :php, ...
Lolp.delete_project('jungly-naha-2778')
Lolp.create_custom_domain('jungly-naha-2778.lolipop.ohr','example.com')
Lolp.delete_custom_domain('jungly-naha-2778.lolipop.ohr','example.com')
Lolp.project_strage('jungly-naha-2778')
```

### Certificate

```ruby
# get certificates infomation
Lolp.get_certificate('agile-kitsuki-0978.lolipop.io')
# create certificates
Lolp.create_certificate('agile-kitsuki-0978.lolipop.io')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing


Bug reports and pull requests are welcome on GitHub at https://github.com/pepabo/lolp.rb.
