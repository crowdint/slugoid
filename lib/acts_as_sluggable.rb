require 'acts_as_sluggable/acts/sluggable'

#
# Include it in Mongoid::Document
#
Mongoid::Document.send(:include, Acts::Sluggable)
