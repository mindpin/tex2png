# Tex2png

A tex to png converter for ruby.

## Installation

Add this line to your application's Gemfile:

    gem "tex2png"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tex2png

## Usage

```ruby
require "text2png"

formula = "\\sum_{i = 0}^{i = n} \\frac{i}{2}"

converter = Text2png::Convert(formula)

converter.png {|file| ...do something with 'file'...}

converter.data #=> "data:image/png;base64, iVBOR...."

converter.png.path #=> "/tmp/tex2png/..."
```

## Contributing

1. Fork it ( https://github.com/mindpin/tex2png/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
