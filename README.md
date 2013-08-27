# RadiantExtensionHelper

Helper to easily copy assets/load config from your radiant extension to your CMS

## Installation

Add this line to your application's Gemfile:

    gem 'radiant_extension_helper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install radiant_extension_helper

## Usage

```ruby
task :update => :environment do
  RadiantExtensionHelper.copy_assets(:extension_name)
end
```

The extension helper will copy everything in public and config/*.yml.example
to the radiant cms.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
