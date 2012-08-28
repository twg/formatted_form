require 'rails'
require 'bootstrap_builder'

class BootstrapBuilder::Engine < Rails::Engine
  initializer 'helper' do |app|
    ActionView::Base.send(:include, BootstrapBuilder::ViewHelper)
    
    # Remove field_with_errors div around elements with errors
    ActionView::Base.field_error_proc = proc { |input, instance| input }
  end
end