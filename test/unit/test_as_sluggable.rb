require 'test_helper'

class Project
  include Mongoid::Document
  include Acts::Sluggable
  
  acts_as_sluggable

  field :name, :type => String
end

class TestActsAsSluggable < Test::Unit::TestCase
  def setup
    ::Mongoid.configure do |config|
      name = "acts_as_sluggable_test"
      host = "localhost"
      config.master = Mongo::Connection.new.db(name)
      config.logger = nil
    end
  end

  context :acts_as_sluggable do
    setup do
      @project = Project.create(:name => 'Some name')
    end

    should "create a slug" do
      assert_equal('some-name', @project.slug)
    end
  end
  
  def teardown
    ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end