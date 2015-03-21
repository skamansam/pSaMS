module Interactor
  def self.included(base)
    base.class_eval do
      def self.perform(*args)
        i = self.new(*args)
        i.perform
      end
    end
    base.extend ClassMethods
  end

  def self.registered(base)
    base.extend ClassMethods
  end
  module ClassMethods
    attr_reader :errors

    def error?
      errors.present?
    end
    alias :failed? :error?

    def succeeded?
      errors.blank?
    end
    alias :success? :succeeded?

  end
end
