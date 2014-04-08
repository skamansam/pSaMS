And /^there is a (\w+) with (\w+) "(.*)"$/ do |obj,att,val|
  @object = obj.capitalize.constantize.find_by(att.to_sym => val) || FactoryGirl.create( obj.to_sym, att.to_sym => val )
end
