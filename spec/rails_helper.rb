# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

if Rails.env == "test" and
    ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLite3Adapter and
    Rails.configuration.database_configuration['test']['database'] == ':memory:'
  load "#{Rails.root}/db/schema.rb"
end

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true

end

def compare_element_to_documentation(element)
  if !element.respond_to?(:keys) && element.respond_to?(:each)
    element.each do |e|
      compare_element_to_documentation(e)
    end
  elsif element.respond_to?(:keys) && element["type"]
    type = element["type"]
    documentation = get_documentation(type)
    if documentation[type]
      documentation[type]["attributes"]["required"].keys.each do |req|
        expect(element.keys).to include(req), "Resource #{type} does not contain required attribute #{req}: #{element}"
      end
      element.each_value do |e|
        compare_element_to_documentation(e)
      end
    else
      raise ArgumentError, "Documentation for resource #{type} has no data. Has keys #{documentation.keys}"
    end
  else
    #noop. This case is hit when values for the resource attributes are passed in
  end
end

def get_documentation(type)
  YAML.load(File.read("doc/resources/#{type}.yml"))
end