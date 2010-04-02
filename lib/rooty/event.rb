module Rooty
  class Event
    
    attr_reader :namespace, :method, :content
    
    def initialize(namespace, method, content)
      @namespace = Rooty::Binding.new(namespace)
      @method = Rooty::Binding.new(method)
      @content = content
    end
    
  end
end