module BootstrapBuilder::Helper
  
  def bootstrap_form_for(record, options = {}, &proc)
    options = options.dup
    options[:builder] = BootstrapBuilder::FormBuilder
    
    options[:html]          ||= { }
    options[:html][:class]  ||= ''
    if !(options[:html][:class] =~ /form-/)
      options[:html][:class] += " #{BootstrapBuilder.config.default_form_class}"
    end
    
    form_for(record, options, &proc)
  end
  
end