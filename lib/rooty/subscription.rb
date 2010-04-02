module Rooty
  class Subscription
  
    attr_reader :namespace, :method, :handler, :uuid
  
    def initialize(namespace, method, handler)
      @uuid = UUID.new.generate
      @namespace = namespace
      @method = method
      @handler = handler
    end
  
    def respond_to_event?(event)
      event.namespace == namespace && event.method == method
    end
  
    def notify(event)
      if handler.is_a?(Proc)
        handler.call(event)
      elsif handler.respond_to?(:run)
        handler.run(event)
      end
    end
    
    def ==(other)
      return false unless other.is_a?(Rooty::Subscription)
      other.uuid == uuid
    end
  
  end
  
end