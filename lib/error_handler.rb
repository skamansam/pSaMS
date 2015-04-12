module ErrorHandler
  @@errors = {}
  @@warnings = {}

  def self.errors
    @@errors
  end

  def self.warnings
    @@warnings
  end

  def self.add_error(key,error)
    if @@errors.has_key?(key)
      unless @@errors[key].detect{|e| error.message == e.message}
        @@errors[key] << error
      end
    else
      @@errors[key] = [error]
    end
  end

  def self.add_warning(key,warning)
    if @@warnings.has_key?(key)
      unless @@warnings[key].detect{|e| warning.message == e.message}
        @@warnings[key] << error
      end
    else
      @@warnings[key] = [warning]
    end
  end

  def self.clear_warnings
    @@warnings = {}
  end

  def self.clear_errors
    @@errors = {}
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def self.registered(base)
    base.extend ClassMethods
  end

  def get_errors
    @@errors[self.name] || @@errors[self.file_name] || []
  end

  def get_warnings
    @@warnings[self.name] || @@warnings[self.file_name] || []
  end

  def error_count
    get_errors.count
  end

  def warning_count
    get_warnings.count
  end

  module ClassMethods
    def get_errors
      ErrorHandler.errors
    end

    def error_count
      get_errors.count
    end

    def error_count_for(key)
      get_errors[key].count
    end

    def clear_errors
      ErrorHandler.clear_errors
    end

    def add_error(key,err)
      ErrorHandler.add_error(key,err)
    end

    def get_warnings
      ErrorHandler.warnings
    end

    def warning_count
      get_warnings.count
    end

    def warning_count_for(key)
      get_warnings[key].count
    end

    def clear_warnings
      ErrorHandler.clear_warnings
    end

    def add_warning(key,warning)
      ErrorHandler.add_warning(key,warning)
    end
  end
end
