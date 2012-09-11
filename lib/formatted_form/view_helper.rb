module FormattedForm::ViewHelper
  
  def formatted_form_for(record, options = {}, &proc)
    options = options.dup
    options[:builder] = FormattedForm::FormBuilder
    
    options[:html] ||= { }
    unless options[:html][:class] =~ /form-/
      options[:html][:class] = "#{options[:html][:class]} #{FormattedForm.config.default_form_class}".strip
    end
    
    form_for(record, options, &proc)
  end
  
end