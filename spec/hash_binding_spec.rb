RSpec.describe Effigie::HashBinding do
  context "when initializing" do
    it 'raises if arg is not an hash' do
      aggregate_failures do
        expect { Effigie::HashBinding.new(nil) }.to raise_error(Effigie::Error)
        expect { Effigie::HashBinding.new(1) }.to raise_error(Effigie::Error)
        expect { Effigie::HashBinding.new("") }.to raise_error(Effigie::Error)
      end
    end
  end

  context "when rendering a template" do
    let(:hash_binding) { Effigie::HashBinding.new(foo: 'bar') }

    it 'renders keys as methods' do
      expect(hash_binding.foo).to eq('bar')
    end

    it 'raises if keys are missing' do
      expect{ hash_binding.baz }.to raise_error(NoMethodError)
    end
  end
end
