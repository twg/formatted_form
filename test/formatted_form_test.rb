require 'test_helper'

class FormattedFormTest < ActiveSupport::TestCase
  
  def test_config
    FormattedForm.configure do |config|
      assert_equal FormattedForm::Configuration, config.class
    end
  end
  
end