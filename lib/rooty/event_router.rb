require 'singleton'

module Rooty
  class EventRouter
    include Singleton
    
    def initialize
      @subscribers = []
    end
    
    def notify(event)
      responders = @subscribers.select { |s| s.respond_to_event?(event) }
      responders.each { |r| r.notify(event) }
    end
    
    def subscribe(namespace, opts = {}, &block)
      methods = [*opts[:method]].compact
      handler = block_given? ? block : opts[:handler]
      
      subs = []
      methods.each { |m| subs << Subscription.new(namespace, m, handler) }
      @subscribers += subs
      subs
    end
    
    def map(opts = {}, &block)
      with_options(opts) { |router| router.instance_eval &block }
    end
    
    def self.method_missing(sym, *args, &block)
      EventRouter.instance.send(sym, *args, &block)
    end
    
  end
end
