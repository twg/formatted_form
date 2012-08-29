require 'test_helper'

# `raise output_buffer.inspect` if you want to peek inside generated html
class FormBuilderTest < ActionView::TestCase
  
  # -- Form -----------------------------------------------------------------
  def test_form
    flunk 'todo'
  end
  
  # -- Text Field -----------------------------------------------------------
  def test_text_field
    flunk 'todo'
  end
  
  # -------------------------------------------------------------------------
  def test_eveything_else
    # each helper should have it's own partial to override
    flunk 'todo'
  end
  
  # -- Element --------------------------------------------------------------
  def test_element
    with_element 'Label', 'Content'
    assert_select 'div[class="control-group"]' do
      assert_select 'label[class="control-label"]', 'Label'
      assert_select 'div[class="controls"]', 'Content'
    end
  end
  
  def test_element_with_block
    with_element 'Label' do
      'Content'
    end
    assert_select 'div[class="control-group"]' do
      assert_select 'label[class="control-label"]', 'Label'
      assert_select 'div[class="controls"]', 'Content'
    end
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