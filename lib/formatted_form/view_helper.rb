module FormattedForm::ViewHelper
  
  def formatted_form_for(record, options = {}, &proc)
    options = options.dup
    options[:builder] ||= FormattedForm::FormBuilder
    
    options[:html] ||= { }
    options[:html][:class] ||= 'formatted'
    
    # :type option will set proper form class. Conversely having
    # proper css class will set the type that controls what html
    # wrappers are used to render form fields
    if type = options[:html][:class].match(/form-(inline|horizontal|search)/)
      options[:type] ||= type[1].try(:to_sym)
    
    elsif options[:type].present?
      form_class = case options[:type]
        when :inline      then 'form-inline'
        when :horizontal  then 'form-horizontal'
        when :search      then 'form-search'
      end
      options[:html][:class] = "#{options[:html][:class]} #{form_class}".strip
    end
    options[:type] ||= :default
    options[:type] = options[:type].to_sym
    
    form_for(record, options, &proc)
  end
  
  # Convenience helper to make templates a bit more dry
  #   content_tag_if(true, :div, 'test')
  #   => <div>test</div>
  #   content_tag_if(false, :div, 'test')
  #   => test
  def content_tag_if(boolean, name, content_or_options_with_block = nil, options = nil, escape = true, &block)
    if boolean
      content_tag(name, content_or_options_with_block, options, escape, &block)
    elsif block_given?
      capture(&block)
    else
      content_or_options_with_block
    end
  end
  
  def content_tag_unless(boolean, name, content_or_options_with_block = nil, options = nil, escape = true, &block)
    content_tag_if(!boolean, name, content_or_options_with_block, options, escape, &block)
  end
  
end
