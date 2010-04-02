module Rooty
  class Binding
    
    attr_reader :value
    
    def initialize(value)
      @value = value
    end
    
    def ==(other)
      return false unless other.is_a?(Rooty::Binding)
      other.value.to_s == value.to_s
    end
    
    # TODO: override to_s
    
  end
end