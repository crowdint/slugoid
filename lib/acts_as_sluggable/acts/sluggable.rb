module Acts
  module Sluggable
    module ClassMethods
      #
      # Adds the logic to generate the slug
      #
      def acts_as_sluggable(method = :name, slug_field_name = :slug)
        class_eval do
          before_save do
            generate_slug(method, slug_field_name)
          end
          field(slug_field_name, :type => String) unless self.respond_to?(slug_field_name)
          index(slug_field_name)
          alias_method :to_param!, :to_param
        end

        define_method("to_param") do
          self.send(slug_field_name)
        end
      end
    end

    module InstanceMethods
      def generate_slug(method, slug_field_name)
        self.send("#{slug_field_name.to_s}=", self.send(method).parameterize)
      end
    end

    def self.included(receiver)
      receiver::ClassMethods.send :include, ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
