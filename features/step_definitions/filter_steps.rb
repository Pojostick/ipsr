When(/^I filter by "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^select "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see mosaics with grid: "([^"]*)"$/) do |grid|
  grid = grid + " transparent"*(79 - grid.count(' '))
  mosaic = Mosaic.find_by_grid(grid)
  page.text.should match(/Mosaic_#{mosaic.id}/)
end

Then(/^I should not see mosaics with grid: "([^"]*)"$/) do |grid|
  grid = grid + " transparent"*(79 - grid.count(' '))
  mosaic = Mosaic.find_by_grid(grid)
  page.text.should_not match(/Mosaic_#{mosaic.id}/)
end