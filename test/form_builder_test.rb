require 'test_helper'

# `raise output_buffer.inspect` if you want to peek inside generated html
class FormBuilderTest < ActionView::TestCase
  
  
  def test_text_field
    flunk 'todo'
  end
  
  # -- Submit ---------------------------------------------------------------
  def test_submit
    with_submit
    assert_select 'input[name=commit][value="Save User"][class="btn btn-primary"]'
  end
  
  def test_submit_with_label
    with_submit 'Create'
    assert_select 'input[name=commit][value="Create"]'
  end
  
  def test_submit_with_css_class
    with_submit :class => 'btn-danger'
    assert_select 'input[name=commit][class="btn-danger btn"]'
  end
  
  def test_submit_with_onsubmit_value
    with_submit :onsubmit_value => 'Loading'
    assert_select 'input[name=commit][data-onsubmit-value="Loading"][data-offsubmit-value="Save User"]'
  end
  
end