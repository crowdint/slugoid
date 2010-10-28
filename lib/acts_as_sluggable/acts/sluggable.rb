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
        @acts_as_sluggable_options = {
          :generate_from => :name,
          :store_as => :slug
        }.merge(options)

        generate_from = @acts_as_sluggable_options[:generate_from]
        store_as = @acts_as_sluggable_options[:store_as]

        class_eval do
          before_save do
            generate_slug(generate_from, store_as)
          end

          field(store_as, :type => String) unless self.respond_to?(store_as)
          index(store_as)
          alias_method :to_param!, :to_param
        end

        define_method("to_param") do
          self.send(store_as)
        end
      end

      def acts_as_sluggable_options
        @acts_as_sluggable_options
      end

      def find_by_slug(slug)
        where(@acts_as_sluggable_options[:store_as] => slug).first
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
