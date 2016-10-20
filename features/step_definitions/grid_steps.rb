Then(/^I should see an? (\d+) by (\d+) grid$/) do |arg1, arg2|
  # check if the # of rows is 10
  page.all('#mosaic tr').count.should == arg2.to_f
  # check if the # of rows is 8
  page.all('#mosaic td').count.should == arg2.to_f * arg1.to_f
end
Then(/^I should see (\d+) colors$/) do |arg1|
  page.all('#selection_colors td').count.should == arg1.to_f
end
Given(/^the (.*) color in the palette is color "([^"]*)"$/) do |which, color|
  pending # Write code here that turns the phrase above into concrete actions
end
When(/^I drag (.*) to (.*)$/) do |drag_from, drag_to|
  pending # Write code here that turns the phrase above into concrete actions
end
Then(/^I should see (.*) in (.*)$/) do |color, location|
  pending # Write code here that turns the phrase above into concrete actions
end
