# Effigie

[![Build Status](https://travis-ci.com/mberlanda/effigie.svg?branch=master)](https://travis-ci.com/mberlanda/effigie) [![Gem Version](https://badge.fury.io/rb/effigie.svg)](https://badge.fury.io/rb/effigie)

Simple utility to render ERB templates from hash, objects or self.
Mostly inspired to SO <https://stackoverflow.com/a/5462069>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'effigie'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install effigie

## Usage

### Using a static file and the default template:

Template under `tasks.erb`:
```erb
These are my tasks:
<% tasks.each do |t| %>* <%= t.name %>: <%= t.due_date %>
<% end %>
```

```rb
Task = Struct.new(:name, :due_date)
template = Effigie::Template.new(filepath)
tasks_list = [Task.new('foo', 'today'), Task.new('bar', 'tomorrow')]

# Using an object responding to these methods
class Agenda
  attr_accessor :tasks
end

agenda = Agenda.new.tap { |a| a.tasks = tasks_list }
template.render(agenda)

# Using an OpenStruct
template.render(OpenStruct.new(tasks: tasks_list))

# Using self
def tasks
  tasks_list
end
template.render(self)

# Using an Effigie::HashBinding
template.render(Effigie::HashBinding.new(tasks: tasks_list))
```

### Using custom subclasses

```rb
# Override default erb private method to avoid reading from file
class HelloTemplate < Effigie::Template
  def erb
    ERB.new("Hello <%= name %>")
  end
end
Person = Struct.new(:name)

HelloWorldTemplate.new.render(Person.new("John Doe"))

# Read from instance variables and methods
class UserTemplate < Effigie::Template
  def erb
    ERB.new("Hello <%= current_user.name %>, welcome into <%= @application %>.")
  end
end

def current_user
  Person.new("John Doe")
end
@application = "Effigie"

UserTemplate.new.render(self)

# Read from an hash table
class HashTemplate < Effigie::Template
  def erb
    ERB.new("Hello <%= self[:name] %>, welcome into <%= self[:application] %>.")
  end
end

HashTemplate.new.render(name: "John Doe", application: "Effigie")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mberlanda/effigie. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Effigie project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mberlanda/effigie/blob/master/CODE_OF_CONDUCT.md).
