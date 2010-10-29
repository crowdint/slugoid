require 'test_helper'

class Project
  include Mongoid::Document

  acts_as_sluggable

  field :name, :type => String
end

class Organization
  include Mongoid::Document

  acts_as_sluggable :generate_from => :alternative_name, :store_as => :alternative_slug

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

  def methods_per_model_assert(expected, model)
    [:find_by_slug, :find].each do |method|
      assert_equal(expected, model.send(method, expected.to_param))
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

    context :using_finders do
      should "find the object" do
        methods_per_model_assert @project, Project
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

    context :using_finders do
      should "find the object" do
        methods_per_model_assert @organization, Organization
      end
    end
  end

  context :acts_as_sluggable_options do
    should "respond to acts_as_sluggable_options" do
      assert_equal(true, Project.respond_to?(:acts_as_sluggable_options))
    end

    should "return the options for acts_as_sluggable" do
      assert_equal(:name, Project.acts_as_sluggable_options[:generate_from])
      assert_equal(:slug, Project.acts_as_sluggable_options[:store_as])
    end
  end

  def teardown
    ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end
