require 'erb'

# The +Effigie::Template+ class provides
# provides some utilities to read an ERB
# template and render it within ruby standard library
class Effigie::Template
  attr_reader :filepath

  # Creates a new instance of +Effigie::Template+
  #
  # Params:
  # +filepath+:: +string+ a file path
  #
  # In case you do not want to read from file
  # You should override +erb+ private method
  #
  # Usage:
  #
  # Reading from file path
  # +Effigie::Template.new("path/to/file.erb")+
  #
  # Overriding +erb+ method
  #
  #    class HelloWorldTemplate < Effigie::Template
  #      def erb
  #        ERB.new("Hello <%= name %>")
  #      end
  #    end
  #
  #    HelloWorldTemplate.new.render(OpenStruct.new(name: "World"))

  def initialize(filepath = nil)
    @filepath = filepath
  end

  # It renders your template out of the +Binding+ instance
  # of the object passed as argument
  #
  # Params:
  # +ctx+:: any object
  #
  # E.g. Usage with +Hash+
  #
  #    class HashTemplate < Effigie::Template
  #      def erb
  #        ERB.new("Hello <%= self[:name] %>")
  #      end
  #    end
  #
  #    HashTemplate.new.render(name: "World")
  #
  # Please see the tests for further examples

  def render(ctx)
    erb.result(ctx.instance_eval { binding })
  end

  private

  def erb
    @erb ||= ERB.new(read)
  end

  def read
    @read ||= File.read(filepath)
  end
end
