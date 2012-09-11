class FormattedForm::Configuration
  
  # The templates folder 
  attr_accessor :template_folder
      
  # The templates folder 
  attr_accessor :default_form_class

  # Configuration defaults
  def initialize
    @template_folder    = 'formatted_form'
    @default_form_class = 'form-horizontal'
  end
end