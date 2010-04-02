module Rooty
  module Rails
    module ActiveModel
      
      def dispatch(callback)
        self.send callback do |model|
          Rooty.notify(self.name.to_s.underscore, callback, model)
        end
      end
      
    end
  end
end