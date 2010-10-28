module Acts
  module Sluggable
    module ClassMethods
      #
      # Adds the logic to generate the slug
      #
      # Options:
      #
      #   :generate_from
      #       The name of the field used to generate the slug
      #
      #   :store_as
      #       The name of the field where the slug will be stored
      #
      def acts_as_sluggable(options = {})
        options = {
          :generate_from => :name,
          :store_as => :slug
        }.merge(options)

        class_eval do
          before_save do
            generate_slug(options[:generate_from], options[:store_as])
          end
          field(options[:store_as], :type => String) unless self.respond_to?(options[:store_as])
          index(options[:store_as])
          alias_method :to_param!, :to_param
        end

        define_method("to_param") do
          self.send(options[:store_as])
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
