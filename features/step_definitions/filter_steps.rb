When (/^I filter by "([^"]*)" and select "([^"]*)" and I filter by "([^"]*)" and select "([^"]*)" and I filter by "([^"]*)" and select "([^"]*)" and I filter by "([^"]*)" and select "([^"]*)" and I press "([^"]*)"$/) do |e1, e2, e3, e4, e5, e6, e7, e8, e9|
    
end

# When(/^I filter by "([^"]*)"$/) do |option|
#   params[:option] => option
# end

# When(/^select "([^"]*)"$/) do |range|
#   params[params[:option].to_sym] => range
# end

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