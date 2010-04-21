module Rooty
  class Subscription
  
    attr_reader :uuid, :binding, :handler
  
    def initialize(namespace, handler)
      @uuid = UUID.new.generate
      @binding = Rooty::Binding.new(namespace)
      @handler = handler
    end
  
    def respond_to_event?(event)
      binding.matches?(event.namespace)
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
