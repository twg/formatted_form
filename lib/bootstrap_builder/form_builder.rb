class BootstrapBuilder::FormBuilder < ActionView::Helpers::FormBuilder
    
  %w(
    text_field 
    password_field 
    email_field
    telephone_field
    phone_field
    number_field
    text_area 
    file_field 
    range_field
    search_field
  ).each do |field_name|
    define_method field_name do |method, *args|
      options = args.detect { |a| a.is_a?(Hash) } || {}
      default_field(field_name, method, options) do 
        super(method, options)
      end
    end
  end

  %w{
    datetime_select 
    date_select 
    time_select 
    time_zone_select
  }.each do |field_name|
    define_method field_name do |method, options = {}, html_options = {}|
      default_field('select', method, options) do
        super(method, options)
      end
    end
  end

  def select(method, choices, options = {}, html_options = {})
    render_field('select', method, options) { super(method, choices, options) } 
  end

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    html_options = collect_html_options(options)
    if options[:values].present?
      values = options.delete(:values).collect do |key, val|
        name = "#{object_name}[#{method}][]"
        id = "#{object_name}_#{method}_#{val.to_s.gsub(' ', '_').underscore}"
        {
          :field => super(method, options.merge({:name => name, :id => id}), val, nil),
          :label_text => key,
          :id => id
        }
      end
      @template.render(:partial => "#{BootstrapBuilder.config.template_folder}/check_box", :locals  => {
        :builder => self,
        :method => method,
        :values => values,
        :label_text => label_text(method, options.delete(:label)),
        :help_block => @template.raw(options.delete(:help_block)),
        :error_messages => error_messages_for(method)
      })
    else
      render_field('check_box', method, options, html_options) do
        super(method, options, checked_value, unchecked_value)
      end
    end
  end
  
  # Radio button helper. Optionally it's possible to specify multiple choices at once:
  #   form.radio_button :role, ['admin', 'regular']
  #   form.radio_button :role, [['Admin', 1], ['Regular', 0]]
  # Outputs an arary of tuples as a :choices option into a partial
  def radio_button(method, tag_value, options = {})
    tag_values = tag_value.is_a?(Array) ? tag_value : [tag_value]
    choices = tag_values.collect do |label, choice|
      label, choice = label, label if !choice
      inline = (options[:class].to_s =~ /inline/) ? ' inline' : nil
      @template.content_tag(:label, :class => "radio#{inline}") do
        super(method, choice, options) + label
      end
    end
    default_field(:radio_button, method, options.merge(:choices => choices))
  end
  
  # Creates submit button element with appropriate bootstrap classes.
  #   form.submit, :class => 'btn-danger'
  def submit(value = nil, options = {}, &block)
    value, options = nil, value if value.is_a?(Hash)
    value ||= submit_default_value
    
    # Add specific bootstrap class
    options[:class] = "#{options[:class]} btn".strip
    options[:class] = "#{options[:class]} btn-primary" unless options[:class] =~ /btn-/
    
    default_field(:submit, nil, options) do
      super(value, options)
    end
  end
  
  # Form helper to render generic content as a form field. For example:
  #   form.element 'Label', 'Content'
  #   form.element 'Label do
  #     Content
  #   end
  def element(label = nil, value = nil, &block)
    options = {:label => label, :content => value }
    default_field(:element, nil, options, &block)
  end
  
  # adding builder class for fields_for
  def fields_for(record_name, record_object = nil, options ={}, &block)
    options[:builder] ||= BootstrapBuilder::FormBuilder
    super(record_name, record_object, options, &block)
  end
  
protected
  
  # Main rendering method
  def default_field(field_name, method, options = {}, &block)
    builder_options = builder_options!(options)
    @template.render(
      :partial => "#{BootstrapBuilder.config.template_folder}/#{field_name}",
      :locals  => { :options => builder_options.merge(
        :builder  => self,
        :method   => method,
        :content  => block_given?? @template.capture(&block) : options.delete(:content),
        :errors   => method ? error_messages_for(method) : nil
      )}
    )
  end
  
  # Extacts parameters that are used for rendering the field
  def builder_options!(options = {})
    [:label, :prepend, :append, :help_block, :choices].each_with_object({}) do |attr, hash|
      hash[attr] = options.delete(attr)
    end
  end
  
  # Collecting errors for a field and outputting first instance
  def error_messages_for(method)
    [object.errors[method]].flatten.first if object && object.respond_to?(:errors)
  end
end