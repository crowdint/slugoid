require 'test_helper'

module Acts::Slugoid::Test

  class TestMongoidFinder < Test::Unit::TestCase

    include Config
    alias :setup! :setup

    def setup
      setup!
      @slugoid_project = SlugoidProject.create!(:name => 'Scott')
      @project         = Project.create!(:name => 'Bauer')
    end

    context "find" do
      should "return the objects when you pass the id" do
        assert_equal(@slugoid_project, SlugoidProject.find(@slugoid_project.to_param))
        assert_equal(@slugoid_project, SlugoidProject.find(@slugoid_project.id))
      end

      should "work as usual for other models" do
        assert_equal @project, Project.find(@project.id)
        assert_equal @project, Project.find(:first, :conditions => {:name => @project.name})
        assert_equal @project, Project.first(:conditions => {:name => @project.name})
      end
    end

    context "explicit find by id" do
      should "return the object" do
        assert_equal(@slugoid_project, SlugoidProject.where(:_id => @slugoid_project.id).first)
        assert_equal(@slugoid_project, SlugoidProject.find(:first, :conditions => {:_id => @slugoid_project.id}))
      end
    end

  end
end
