# Helper methods defined here can be accessed in any controller or view in the application

module PSaMs
  class Admin
    module PluginHelper
      def error_check
        if (errors = ErrorHandler.errors).present?
          errors.map do |plugin_path, err|
            plugin_relative_path = Pathname.new(plugin_path).relative_path_from(Pathname.new(Padrino.root))
            "There #{err.size > 1 ? "were #{err.size} errors": 'was an error'} with the file #{plugin_relative_path}:<br/> <ul><li>#{err.map(&:message).join('</li><li>')}</li></ul>"
          end.join('<br/>').html_safe
        end
      end
    end
    helpers PluginHelper
  end
end
