module Rooty
  class Binding
    
    attr_reader :value
    
    def initialize(value)
      @value = value
    end
    
    def matches?(namespace)
      return false if namespace.nil?
      case @value
        when String
          @value == namespace.to_s
        when Symbol
          @value == namespace.to_sym
        when Regexp
          namespace.to_s.match @value
        else
          false
      end
    end
    
  end
end
