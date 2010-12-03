require 'slugoid/acts/slugoid'
require 'slugoid/mongoid/criterion/optional'

Mongoid::Document.send(:include, Acts::Slugoid)