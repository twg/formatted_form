require 'bootstrap_builder/engine'
require 'bootstrap_builder/configuration'
require 'bootstrap_builder/form_builder'
require 'bootstrap_builder/view_helper'

module BootstrapBuilder
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

