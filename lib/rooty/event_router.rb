module Rooty
  class EventRouter
    include Singleton
    
    attr_reader :subscribers
    
    def initialize
      @subscribers = []
      @cache = {}
    end
    
    def notify(event)
      puts ">> notify [#{event.inspect}]"
      responders = @cache[event.namespace] ||= @subscribers.select { |s| s.respond_to_event?(event) }
      responders.each { |r| r.notify(event) }
    end
    
    def subscribe(namespace, opts = {}, &block)
      flush
      handler = block_given? ? block : opts[:handler]
      @subscribers << Subscription.new(namespace, handler)
    end
    
    def unsubscribe
      # todo: use partition to set the arrays and return the deleted ones
      # flush
    end
    
    def flush
      @cache = {} unless @cache.empty?
    end
    
    def map(opts = {}, &block)
      with_options(opts) { |router| router.instance_eval &block }
    end
    
    def self.method_missing(sym, *args, &block)
      EventRouter.instance.send(sym, *args, &block)
    end
    
  end
end
