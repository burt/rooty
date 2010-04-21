module Rooty
  class Event
    
    attr_reader :namespace, :content
    
    def initialize(namespace, content)
      @namespace = namespace
      @content = content
    end
    
  end
end
