module BootstrapBuilder::ViewHelper
  
  def bootstrap_form_for(record, options = {}, &proc)
    options = options.dup
    options[:builder] = BootstrapBuilder::FormBuilder
    
    options[:html] ||= { }
    unless options[:html][:class] =~ /form-/
      options[:html][:class] = "#{options[:html][:class]} #{BootstrapBuilder.config.default_form_class}".strip
    end
    
    form_for(record, options, &proc)
  end
  
end