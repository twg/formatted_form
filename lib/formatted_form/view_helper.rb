module FormattedForm::ViewHelper
  
  def formatted_form_for(record, options = {}, &proc)
    options = options.dup
    options[:builder] = FormattedForm::FormBuilder
    
    options[:html] ||= { }
    options[:html][:class] ||= ''
    if !(options[:html][:class] =~ /form-/)
      options[:html][:class] = "#{options[:html][:class]} form-horizontal".strip
    end
    
    form_for(record, options, &proc)
  end
  
end
