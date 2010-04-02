module Rooty
  class Event
    
    attr_reader :namespace, :method, :content
    
    def initialize(namespace, method, content)
      @namespace = namespace
      @method = method
      @content = content
    end
    
  end
end