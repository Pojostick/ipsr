Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then(/^I should see images$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click on test (.*) $/) do |test_num|
  pending # Write code here that turns the phrase above into concrete actions
end
Then(/^I should be on the test (.*) display page$/) do |testNum|
  pending # Write code here that turns the phrase above into concrete actions
end