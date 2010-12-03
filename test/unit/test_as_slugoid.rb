require 'test_helper'

module Acts::Slugoid::Test

  class TestSlugoid < Test::Unit::TestCase

    include Config 

    def methods_per_model_assert(expected, model)
      [:find_by_slug, :find].each do |method|
        assert_equal(expected, model.send(method, expected.to_param))
      end
    end

    context "default parameters" do
      setup do
        @slugoid_project = SlugoidProject.create(:name => 'Some name')
      end

      should "create a slug" do
        assert_equal('some-name', @slugoid_project.slug)
      end

      context :to_param do
        should "return the slug too" do
          assert_equal('some-name', @slugoid_project.to_param)        
        end
      end

      context :using_finders do
        should "find the object" do
          methods_per_model_assert @slugoid_project, SlugoidProject
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

    context :acts_as_slugoid_options do
      should "respond to acts_as_slugoid_options" do
        assert_equal(true, SlugoidProject.respond_to?(:acts_as_slugoid_options))
      end

      should "return the options for acts_as_slugoid" do
        assert_equal(:name, SlugoidProject.acts_as_slugoid_options[:generate_from])
        assert_equal(:slug, SlugoidProject.acts_as_slugoid_options[:store_as])
      end
    end

  end
end
