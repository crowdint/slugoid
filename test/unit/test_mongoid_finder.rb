require 'test_helper'

class Flower
  include Mongoid::Document
end

class Ramona
  include Mongoid::Document
  
  acts_as_sluggable
  
  field :name
end

class TestMongoidFinder < Test::Unit::TestCase
  def setup
    @ramona = Ramona.create!(:name => 'Scott')
    @flower = Flower.create!
  end

  context "find" do
    should "return the objects when you pass the id" do
      assert_equal(@ramona, Ramona.find(@ramona.to_param))
      assert_equal(@flower, Flower.find(@flower.id))
    end
  end

  context "explicit find by id" do
    should "return the object" do
      assert_equal(@ramona, Ramona.where(:_id => @ramona.id).first)
      assert_equal(@ramona, Ramona.find(:first, :conditions => {:_id => @ramona.id}))
    end
  end

  def teardown
    ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end