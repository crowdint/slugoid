require 'rubygems'
require 'test/unit'
require 'bundler/setup'
require 'shoulda'
require 'mongoid'
require 'slugoid'

$LOAD_PATH.unshift(File.dirname(__FILE__))

module Acts::Slugoid::Test
  module Config
    def setup
      ::Mongoid.configure do |config|
        name = "slugoid_test"
        host = "localhost"
        config.master = Mongo::Connection.new.db(name)
        config.logger = nil
      end
    end

    def teardown
      ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
    end
  end
end

class Project
  include Mongoid::Document
  field :name, :type => String
end

class SlugoidProject
  include Mongoid::Document
  field :name, :type => String
  acts_as_slugoid
end

class Organization
  include Mongoid::Document

  acts_as_slugoid :generate_from => :alternative_name, :store_as => :alternative_slug

  field :alternative_name, :type => String
  field :alternative_slug, :type => String
end

