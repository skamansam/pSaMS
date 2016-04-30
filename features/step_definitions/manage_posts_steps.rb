When(/^go to the new posts page$/) do
  visit '/posts/new'
end

When(/^I fill in the fields:$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I go to the category page for testCat$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)" is \.post \.title (\d+)$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end
