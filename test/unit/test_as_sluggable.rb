require 'test_helper'

class Project
  include Mongoid::Document

  acts_as_sluggable

  field :name, :type => String
end

class Organization
  include Mongoid::Document

  acts_as_sluggable :alternative_name, :alternative_slug

  field :alternative_name, :type => String
  field :alternative_slug, :type => String
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

  context "default parameters" do
    setup do
      @project = Project.create(:name => 'Some name')
    end

    should "create a slug" do
      assert_equal('some-name', @project.slug)
    end

    context :to_param do
      should "return the slug too" do
        assert_equal('some-name', @project.to_param)        
      end
    end
  end

  context "custom parameters" do
    setup do
      @organization = Organization.create(:alternative_name => 'Some Other Name')
    end

    should "create a slug using the custom field and store it on the custom slug field" do
      assert_equal('some-other-name', @organization.alternative_slug)
    end

    context :to_param do
      should "return the slug too" do
        assert_equal('some-other-name', @organization.to_param)        
      end
    end
  end

  def teardown
    ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end