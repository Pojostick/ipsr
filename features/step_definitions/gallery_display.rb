Given /^(?:|I )am on (.+)$/ do |page_name|
  request.session[:user_id] = 10000
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

When(/^I select a date ranging from (\d+) to (\d+)$/) do |d1, d2|
  pending # Select d1 and d2
end

Then(/^I should only see mosaics ranging from (\d+) to (\d+)$/) do |d1, d2|
  pending # Ensure all available mosaics have updated_at dates between d1 and d2
end
