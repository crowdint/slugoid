require 'test_helper'

module Acts::Sluggable::Test

  class TestMongoidFinder < Test::Unit::TestCase

    include Config
    alias :setup! :setup

    def setup
      setup!
      @sluggable_project = SluggableProject.create!(:name => 'Scott')
      @project = Project.create!
    end

    context "find" do
      should "return the objects when you pass the id" do
        assert_equal(@sluggable_project, SluggableProject.find(@sluggable_project.to_param))
        assert_equal(@project, Project.find(@project.id))
      end
    end

    context "explicit find by id" do
      should "return the object" do
        assert_equal(@sluggable_project, SluggableProject.where(:_id => @sluggable_project.id).first)
        assert_equal(@sluggable_project, SluggableProject.find(:first, :conditions => {:_id => @sluggable_project.id}))
      end
    end

  end
end
