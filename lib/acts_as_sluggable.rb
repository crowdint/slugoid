require 'mongoid'

module Acts
  module Sluggable
    module ClassMethods
      def acts_as_sluggable(method = :name)
        class_eval do
          before_save do
            generate_slug(method)
          end
          field :slug, :type => String
          index(method)
        end
      end
    end

    module InstanceMethods
      def generate_slug(method)
        self.slug = self.send(method).parameterize
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
