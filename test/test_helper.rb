require 'rubygems'
require 'test/unit'
require 'bundler/setup'
require 'shoulda'
require 'mongoid'

require 'acts_as_sluggable'

# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
