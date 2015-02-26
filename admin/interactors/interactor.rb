module Interactor
  def self.included(base)
    base.extend ClassMethods
  end

  def self.registered(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessible :errors

    def self.perform(*args)
      i = new(*args)
      i.perform
    end

    def error?
      errors.present?
    end
    alias :failed? :error?
    
    def succeeded?
      errors.blank?
    end
    alias :succeeded? :success?

  end 
end