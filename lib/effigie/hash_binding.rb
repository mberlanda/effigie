# The +Effigie::HashBinding+ class provides
# provides a wrapper to define a Binding out of an Hash

class Effigie::HashBinding
  # Creates a new instance of +Effigie::HashBinding+
  #
  # Params:
  # +hash+:: +Hash+ an hash

  def initialize(hash)
    raise Effigie::Error.new("Effigie::HashBinding requires an Hash as argument.") unless hash.is_a?(Hash)
    hash.each do |key, value|
      singleton_class.send(:define_method, key) { value }
    end
  end
end
