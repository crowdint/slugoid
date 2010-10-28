# acts_as_sluggable

Whenever you use MongoDB and Mongoid, there's a high chance you will end up preparing your urls
with a slug instead of the traditional ids because MongoDB ids are ugly.

This gem will help you generate slugs in an easy way

## Compatibility

So far it works with the Rails 3 version of Mongoid.

# Installation

## Rails 3

Include it in your Gemfile:

    gem 'acts_as_sluggable'

And run bundler

    bundle install

# Usage

To use it, all you have to do is call *acts_as_sluggable* in your Mongoid::Document

    class Project
      include Mongoid::Document

      acts_as_sluggable
    end

By default, this will declare a field on the Document called :slug and will try to generate the slug from
a field called :name.

## Options

### :generate_from

If you want to change the field to generate the slug you can use the :generate_from option:

    class Organization
      include Mongoid::Document

      field :alternative_name
      acts_as_sluggable :generate_from => :alternative_name
    end

This will generate the slug form a field called :alternative_name.

### :store_as

If you want to change the field where the slug is stored you can use the :store_as option:

    class Organization
      include Mongoid::Document

      field :name
      acts_as_sluggable :store_as => :alternative_slug
    end

Now it will store the slug in a field called :alternative_slug. If the specified field is not defined
on the Document it will be automatically declared, so adding:

    field :alternative_slug

is optional.

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development company that happens to work in Colima, Mexico. 
We specialize in building and growing online retail stores. We don’t work with everyone – just companies we believe in. Call us today to see if there’s a fit.
Find more info [here](http://www.crowdint.com)!