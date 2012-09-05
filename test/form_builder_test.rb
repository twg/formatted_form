require 'test_helper'

# `raise output_buffer.inspect` if you want to peek inside generated html
class FormBuilderTest < ActionView::TestCase
  
  # -- Form -----------------------------------------------------------------
  def test_form
    with_bootstrap_form_for(@user, :url => ''){|f|}
    assert_select "form[class='form-horizontal']"
  end
  
  def test_form_with_existing_class
    with_bootstrap_form_for(@user, :url => '', :html => {:class => 'formatted'}){|f|}
    assert_select "form[class='formatted form-horizontal']"
  end
  
  def test_form_with_override_class
    with_bootstrap_form_for(@user, :url => '', :html => {:class => 'form-inline'}){|f|}
    assert_select "form[class='form-inline']"
  end
  
  # -- Text Field -----------------------------------------------------------
  def test_text_field
    with_text_field :name
    
    assert_select "div[class='control-group']" do
      assert_select "label[for='user_name']", 'Name'
      assert_select "div[class='controls']" do
        assert_select "input[type='text'][id='user_name'][name='user[name]']"
      end
    end
  end
  
  def test_text_field_prepend_append
    with_text_field :twitter, :prepend => '@', :append => '!'
    
    assert_select "div[class='control-group']" do
      assert_select "label[for='user_twitter']", 'Twitter'
      assert_select "div[class='controls input-prepend input-append']" do
        assert_select "span[class='add-on']", '@'
        assert_select "input[type='text'][id='user_twitter'][name='user[twitter]']"
        assert_select "span[class='add-on']", '!'
      end
    end
  end
  
  def test_text_field_with_help_block
    with_text_field :name, :help_block => 'Help'
    assert_select "div[class='control-group']" do
      assert_select "div[class='controls']" do
        assert_select "input[type='text'][id='user_name'][name='user[name]']"
        assert_select "span[class='help-block']", 'Help'
      end
    end
  end
  
  def test_text_field_with_errors
    assert @user.invalid?
    with_text_field :name
    
    assert_select "div[class='control-group error']" do
      assert_select "div[class='controls']" do
        assert_select "input[type='text'][id='user_name'][name='user[name]']"
        assert_select "span[class='help-inline']", "can&#x27;t be blank"
      end
    end
  end
  
  # -- Radio Button ---------------------------------------------------------
  def test_radio_button
    with_radio_button :role, 'admin'
    assert_select "div[class='control-group']" do
      assert_select "div[class='control-label']", 'Role'
      assert_select "div[class='controls']" do
        assert_select "label[class='radio']", 'admin' do
          assert_select "input[type='radio'][id='user_role_admin'][name='user[role]'][value='admin']"
        end
      end
    end
  end
  
  def test_radio_button_with_custom_label
    with_radio_button :role, 'admin', :label => 'Access'
    assert_select "div[class='control-label']", 'Access'
  end
  
  def test_radio_button_with_choices_array
    with_radio_button :role, ['admin', 'regular']
    assert_select "div[class='controls']" do
      assert_select "label[class='radio']", 'admin' do
        assert_select "input[type='radio'][id='user_role_admin'][name='user[role]'][value='admin']"
      end
      assert_select "label[class='radio']", 'regular' do
        assert_select "input[type='radio'][id='user_role_regular'][name='user[role]'][value='regular']"
      end
    end
  end
  
  def test_radio_button_with_choices_tuples
    with_radio_button :role, [['Admin', 1], ['Regular', 2]]
    assert_select "label[class='radio']", 'Admin' do
      assert_select "input[type='radio'][id='user_role_1'][name='user[role]'][value='1']"
    end
    assert_select "label[class='radio']", 'Regular' do
      assert_select "input[type='radio'][id='user_role_2'][name='user[role]'][value='2']"
    end
  end
  
  def test_radio_button_inline
    with_radio_button :role, 'admin', :class => 'inline'
    assert_select "label[class='radio inline']", 'admin' do
      assert_select "input[type='radio'][id='user_role_admin'][name='user[role]'][value='admin']"
    end
  end
  
  # -- Check Boxes ----------------------------------------------------------
  def test_check_box
    with_check_box :colors, {}, 'yes', 'no'
    assert_select "div[class='control-group']" do
      assert_select "div[class='control-label']", 'Colors'
      assert_select "div[class='controls']" do
        assert_select "label[class='checkbox']" do
          assert_select "input[type='hidden'][name='user[colors]'][value='no']"
          assert_select "input[type='checkbox'][id='user_colors'][name='user[colors]'][value='yes']"
        end
      end
    end
  end
  
  def test_check_box_custom_label
    with_check_box :colors, :label => 'Kolors'
    assert_select "div[class='control-label']", 'Kolors'
  end
  
  def test_check_box_with_choices_array
    with_check_box :colors, {}, ['red', 'green']
    assert_select "div[class='control-group']" do
      assert_select "div[class='control-label']", 'Colors'
      assert_select "div[class='controls']" do
        assert_select "label[class='checkbox']", 'red' do
          assert_select "input[type='checkbox'][id='user_colors_red'][name='user[colors][]'][value='red']"
        end
        assert_select "label[class='checkbox']", 'green' do
          assert_select "input[type='checkbox'][id='user_colors_green'][name='user[colors][]'][value='green']"
        end
      end
    end
  end
  
  def test_check_box_with_choices_and_labels
    with_check_box :colors, {}, [['Red', 'r'], ['Green', 'g']]
    assert_select "div[class='controls']" do
      assert_select "label[class='checkbox']", 'Red' do
        assert_select "input[type='checkbox'][id='user_colors_r'][name='user[colors][]'][value='r']"
      end
      assert_select "label[class='checkbox']", 'Green' do
        assert_select "input[type='checkbox'][id='user_colors_g'][name='user[colors][]'][value='g']"
      end
    end
  end
  
  def test_check_box_inline
    with_check_box :colors, :class => 'inline'
    assert_select "label[class='checkbox inline']" do
      assert_select "input[type='checkbox'][id='user_colors'][name='user[colors]']"
    end
  end
  
  # -- Element --------------------------------------------------------------
  def test_element
    with_element 'Label', 'Content'
    assert_select "div[class='control-group']" do
      assert_select "label[class='control-label']", 'Label'
      assert_select "div[class='controls']", 'Content'
    end
  end
  
  def test_element_with_block
    with_element 'Label' do
      'Content'
    end
    assert_select "div[class='control-group']" do
      assert_select "label[class='control-label']", 'Label'
      assert_select "div[class='controls']", 'Content'
    end
  end
  
  # -- Submit ---------------------------------------------------------------
  def test_submit
    with_submit
    assert_select "input[name=commit][value='Create User'][class='btn btn-primary']"
  end
  
  def test_submit_with_label
    with_submit 'Create'
    assert_select "input[name='commit'][value='Create']"
  end
  
  def test_submit_with_css_class
    with_submit :class => 'btn-danger'
    assert_select "input[name=commit][class='btn-danger btn']"
  end
  
end