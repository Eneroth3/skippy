# Skippy

[![Gem Version](https://badge.fury.io/rb/skippy.svg)](https://badge.fury.io/rb/skippy)

Skippy is a Command Line Interface which aims to automate common developer tasks for SketchUp Ruby extension development.

It is currently in very early stage of development so many things are incomplete. Feedback and contributions are welcome.

Some of the main goals are:

* Automate common tasks
  * Packaging the extension
  * Running build scripts
* Easy interface to add per-project custom commands/tasks
* Quick initialization of new project with templates
* Library dependency management
  * Pull in third-party modules into extension namespace
  * Add/Remove/Update dependencies

## Installation

    $ gem install skippy

## Usage

TODO: Write more detailed usage instructions here.

Install the gem on your system, afterwards the `skippy` command should become available.

### Quick-Reference

Type `skippy` to list available commands.

Type `skippy help [COMMAND]` for more information on how to use each command.

Use `skippy new` to create a new project in the current folder.

You can add custom per-project commands to a `skippy` folder in your project. Look at `skippy/example.rb` for an example of a simple custom command.

### Power of Thor

Skippy is built on [Thor](https://github.com/erikhuda/thor). Refer to [Thor's Website](http://whatisthor.com/) and [documentation](http://www.rubydoc.info/github/wycats/thor/index) for details on creating commands.

When creating Skippy command use the following replacements:

* Instead of class `Thor`, use `Skippy::Command`
* Instead of class `Thor::Group`, use `Skippy::Command::Group`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thomthom/skippy.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

