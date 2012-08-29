# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class ActionView::TestCase
  include BootstrapBuilder::ViewHelper
  
  def with_bootstrap_form_for(*args, &block)
    concat bootstrap_form_for(*args, &block)
  end
  
  def with_submit(*args)
    with_bootstrap_form_for(:user, :url => ''){ |f| f.submit *args }
  end
  
end