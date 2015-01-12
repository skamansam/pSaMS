module ErrorHandler
  @@errors = {}

  def self.errors
    @@errors
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

  def self.included(base)
    base.extend ClassMethods
  end

  def self.registered(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def get_errors
      ErrorHandler.errors
    end
    def add_error(key,err)
      ErrorHandler.add_error(key,err)
    end
  end
end
