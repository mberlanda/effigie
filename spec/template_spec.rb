RSpec.describe Effigie::Template do
  context "when using the default class" do
    let(:filepath) { File.join(File.dirname(__FILE__), 'templates', 'tasks.erb') }
    let!(:template) { Effigie::Template.new(filepath) }
    let(:expected) do
<<~EXPECTED
These are my tasks:
* foo: today
* bar: tomorrow
EXPECTED
    end

    Task = Struct.new(:name, :due_date)

    it 'should render out of an Effigie::HashBinding cxt passed' do
      expect(
        template.render(Effigie::HashBinding.new(tasks: [Task.new('foo', 'today'), Task.new('bar', 'tomorrow')]))
      ).to eq(expected)
    end

    it 'should render out of an OpenStruct cxt passed' do
      require 'ostruct'
      expect(
        template.render(OpenStruct.new(tasks: [Task.new('foo', 'today'), Task.new('bar', 'tomorrow')]))
      ).to eq(expected)
    end

    it 'should render out of any class methods cxt' do
      class Agenda
        attr_accessor :tasks
      end

      agenda = Agenda.new
      agenda.tasks = [Task.new('foo', 'today'), Task.new('bar', 'tomorrow')]

      expect(template.render(agenda)).to eq(expected)
    end

    it 'should render out of any method and self cxt' do
      def tasks
        [Task.new('foo', 'today'), Task.new('bar', 'tomorrow')]
      end

      expect(template.render(self)).to eq(expected)
    end
  end

  context "when using custom templates" do
    class HashTemplate < Effigie::Template
      def erb
        ERB.new("Hello <%= self[:name] %>!")
      end
    end

    it 'renders an Hash template' do
      expect(HashTemplate.new.render(name: 'World')).to eq('Hello World!')
    end

    class ArrayTemplate < Effigie::Template
      def erb
        ERB.new("I have <%= self.size %> items: <%= self.join(', ') %>.")
      end
    end

    it 'renders an Array template' do
      expect(ArrayTemplate.new.render([1, 2, 3])).to eq('I have 3 items: 1, 2, 3.')
    end
  end
end
