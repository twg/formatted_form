require 'formatted_form/engine'
require 'formatted_form/configuration'
require 'formatted_form/form_builder'
require 'formatted_form/view_helper'

module FormattedForm
  class << self
    
    def configure
      yield configuration
    end
    
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration
    
  end
end

