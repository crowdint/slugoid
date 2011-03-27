module Mongoid::Criterion::Optional
  #
  # Overwrite the id method to find objects
  # by the specified slug rather than the id.
  # If you want to find via id you'll have to use
  # An explicit finder like:
  #
  #   where(:_id => some_id)
  #
  alias :for_ids! :for_ids
  def for_ids(*ids)
    unless ids.first.is_a?(BSON::ObjectId)
      ids.flatten!
      if ids.size > 1
        self.in(
          @klass.acts_as_slugoid_options[:store_as] => ::BSON::ObjectId.cast!(@klass, ids, @klass.primary_key.nil?)
        )
      else
        @selector[@klass.acts_as_slugoid_options[:store_as]] = ids.first
      end
      self
    else
      for_ids!(*ids)
    end
  end
end
