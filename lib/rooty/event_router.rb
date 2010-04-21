module Rooty
  class EventRouter
    include Singleton
    
    attr_reader :subscribers
    
    def initialize
      @subscribers = []
    end
    
    def notify(event)
      responders = @subscribers.select { |s| s.respond_to_event?(event) }
      responders.each { |r| r.notify(event) }
    end
    
    def subscribe(namespace, opts = {}, &block)
      handler = block_given? ? block : opts[:handler]
      @subscribers << Subscription.new(namespace, handler)
    end
    
    def unsubscribe
      # todo: use partition to set the arrays and return the deleted ones
    end
    
    def map(opts = {}, &block)
      with_options(opts) { |router| router.instance_eval &block }
    end
    
    def self.method_missing(sym, *args, &block)
      EventRouter.instance.send(sym, *args, &block)
    end
    
  end
end
