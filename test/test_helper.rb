ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require 'trailblazer/rails/test/integration'

class ActiveSupport::TestCase
  Cell::TestCase.class_eval do
    include Capybara::DSL
    include Capybara::Assertions
  end
end
