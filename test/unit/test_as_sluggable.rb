require 'test_helper'

module Acts::Sluggable::Test

  class TestActsAsSluggable < Test::Unit::TestCase

    include Config 

    def methods_per_model_assert(expected, model)
      [:find_by_slug, :find].each do |method|
        assert_equal(expected, model.send(method, expected.to_param))
      end
    end

    context "default parameters" do
      setup do
        @sluggable_project = SluggableProject.create(:name => 'Some name')
      end

      should "create a slug" do
        assert_equal('some-name', @sluggable_project.slug)
      end

      context :to_param do
        should "return the slug too" do
          assert_equal('some-name', @sluggable_project.to_param)        
        end
      end

      context :using_finders do
        should "find the object" do
          methods_per_model_assert @sluggable_project, SluggableProject
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
        assert_equal(true, SluggableProject.respond_to?(:acts_as_sluggable_options))
      end

      should "return the options for acts_as_sluggable" do
        assert_equal(:name, SluggableProject.acts_as_sluggable_options[:generate_from])
        assert_equal(:slug, SluggableProject.acts_as_sluggable_options[:store_as])
      end
    end

  end
end
