require 'acts_as_sluggable/acts/sluggable'
require 'acts_as_sluggable/mongoid/criterion/optional'

Mongoid::Document.send(:include, Acts::Sluggable)