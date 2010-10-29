Mongoid::Document.send(:include, Acts::Sluggable)

module Mongoid::Finders
  alias :find! :find

  def find(*args)
    where(@acts_as_sluggable_options[:store_as] => args[0]).first || find!(*args)
  end
end
