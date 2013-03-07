# TOMLp

TOMLp is a library to parse the [TOML configuration format](https://github.com/mojombo/toml).

It has a fairly exhaustive test coverage and is compliant with the latest revision of TOML specifications.

_**This is not yet production ready.**_

## Installation

Add this line to your application's Gemfile:

    gem 'tomlp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tomlp

## Usage

Straightforward.

    content = '
    [key]
    something = "value"
    '

    TOMLP.parse(content)
    # => {"key" => {"something" => "value"}

Or you could also directly load the contents from a file.

    TOMLP.load("path_to_your_toml_file")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
