# TODO
# - unique ids for subscriptions
# - error handling
# -- test handler is valid
# -- test methods are supplied
# -- test namespace is given
# - unsubscribe
# - routing with regular expressions

require 'rubygems'
require 'active_support'
require 'uuid'

require 'rooty/event_router'
require 'rooty/event'
require 'rooty/subscription'

module Rooty
  
  class << self
  
    def notify(namespace, method, content)
      e = Rooty::Event.new(namespace, method, content)
      Rooty::EventRouter.notify(e)
    end
  
    def subscribe(namespace, opts = {}, &block)
      Rooty::EventRouter.subscribe(namespace, opts, &block)
    end
    
    def map(opts = {}, &block)
      Rooty::EventRouter.map(opts, &block)
    end
    
  end
  
end

class MockHandler
  def run(e)
    puts "mock handler #{e}"
  end
end

#Rooty.subscribe "post", :method => "after_create" do |e|
#  puts "ok from proc '#{e.content[:message]}'"
#end

#Rooty.subscribe "post", :method => "after_create", :handler => lambda { |e| puts "ok from inline proc #{e}" }

#Rooty.subscribe "post", :method => "after_create", :handler => MockHandler.new


r = Rooty.map :handler => MockHandler.new do
  subscribe "post", :method => "after_create"
  subscribe "post", :method => "after_create"
end

#r = Rooty.subscribe "post", :method => "after_create", :handler => MockHandler.new

puts "returned #{r.size}"

Rooty.notify("post", "after_create", :message => "hello")

