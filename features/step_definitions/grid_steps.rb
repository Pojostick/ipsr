def parse_location(location)
  if location[0...5] == "color" # color in palette
    location =~ /color (\d+)/
    "div#src#{$1}"
  else # a grid location
    location =~ /grid location \((\d+), (\d+)\)/
    "div##{8 * $2.to_i + $1.to_i}"
  end
end

Then(/^I should see an? (\d+) by (\d+) grid$/) do |arg1, arg2|
  # check if the # of rows is 10
  page.all('#mosaic tr').count.should == arg2.to_f
  # check if the # of rows is 8
  page.all('#mosaic td').count.should == arg2.to_f * arg1.to_f
end

Then(/^I should see (\d+) colors$/) do |arg1|
  page.all('#selection_colors td').count.should == arg1.to_f
end

Given(/^color (\d+) in the palette is the color "([^"]*)"$/) do |which, color|
  if not defined? $colors
    $colors = Hash.new
  end
  style = page.first("div#src#{which}")[:style]
  style =~ /background-color:[^#]*([^;]+)/
  $colors[color.to_sym] = $1
end

When(/^I drag (.*) to (.*)$/) do |drag_from, drag_to|
  origin = parse_location drag_from
  destination = parse_location drag_to
  puts origin
  draggable = page.first(origin)
  puts draggable
  droppable = page.first(destination)
  draggable.drag_to(droppable)
end

Then(/^I should see (.*) in (.*)$/) do |color, location|
  color_hex = $colors[color.to_sym]
  destination = parse_location location
  
  expect(page.first(destination).native.css_internal("background-color")).to eq(color_hex)
end
