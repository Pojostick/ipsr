Given /^I have a "([^\"]+)" page cookie set to "([^\"]+)"$/ do |game, cookie|
    pending #  visit path_to(page_name)
end

When /^I have already finished a game with result: "([^"]*)"$/ do |myresult|
    pending # Write code here that turns the phrase above into concrete actions
end

When /^I go to the "([^\"]+)" page with cookie: "([^\"]+)"$/ do |game, cookie|
    pending # Write code here that turns the phrase above into concrete actions
end

Then /^I should see "([^\"]+)"$/ do |notice|
    pending # Write code here that turns the phrase above into concrete actions
    # "You have already finished the game once. Future results won't be recorded."
end

Then /^I should be able to play the game again to get a new result: "([^"]*)"$/ do |my_result|
    pending # Write code here that turns the phrase above into concrete actions
end

Then /^I should not see "([^"]*)" in the gallery$/ do |my_result|
    pending # Write code here that turns the phrase above into concrete actions
end