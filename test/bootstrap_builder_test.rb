require 'test_helper'

class SimpleFormTest < ActiveSupport::TestCase
  
  def test_config
    BootstrapBuilder.configure do |config|
      assert_equal BootstrapBuilder::Configuration, config.class
    end
  end
  
end