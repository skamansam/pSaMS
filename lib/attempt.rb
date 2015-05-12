module Attempt
  module ObjectExtensions
    def attempt(the_method = nil)
      return self unless self  #guard for nil
      if block_given?
        yield(self)
      elsif the_method
        the_method.to_proc.try(self)
      else
        self
      end
    end

  end

end

class Object
  include Attempt::ObjectExtensions
end
