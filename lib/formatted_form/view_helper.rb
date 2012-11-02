module FormattedForm::ViewHelper
  
  def formatted_form_for(record, options = {}, &proc)
    options = options.dup
    options[:builder] = FormattedForm::FormBuilder
    form_for(record, options, &proc)
  end
  
end
