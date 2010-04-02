require 'singleton'

module Rooty
  class EventRouter
    include Singleton
    
    attr_reader :subscribers
    
    def initialize
      @subscribers = []
    end
    
    def notify(event)
      responders = @subscribers.select { |s| s.respond_to_event?(event) }
      responders.each do |r|
        if r.async == true
          puts ">>>>>>>>>>>>>>> q this event"
          # get the adaptor from config
          Resque.enqueue(Rooty::Async::ResqueJob, event.namespace.value)
        else
          puts ">>>>>>>>>>>>>>> execute this event"
          r.notify(event)
        end
      end
    end
    
    def subscribe(namespace, opts = {}, &block)
      methods = [*opts[:method]].compact
      handler = block_given? ? block : opts[:handler]
      async = opts[:async] == true
      subs = []
      methods.each { |m| subs << Subscription.new(namespace, m, handler, async) }
      @subscribers += subs
      subs
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
