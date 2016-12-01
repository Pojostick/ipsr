Given /^the following images exist:$/ do |table|

	table.hashes.each do |mosaic|
  grid = mosaic[:grid] + " transparent"*(79 - mosaic[:grid].count(' '))
		Mosaic.new(:steps => mosaic[:steps],
				 :grid => grid, :step_counter => mosaic[:step_counter], :number_of_colors => mosaic[:number_of_colors],
				 :dominant_color => mosaic[:dominant_color]).save!
	end
end

When (/^I follow the link mosaic(.*)$/) do |mosaic_id|
    click_link("Mosaic ##{mosaic_id}")
end

When /^(?:|I )check download box for mosaic with grid: "([^"]*)"$/ do |grid|
  grid = grid + " transparent"*(79 - grid.count(' '))
  mosaic = Mosaic.find_by_grid(grid)
  check("mosaics_#{mosaic.id}")
end

Then /^I should be able to download the file with file name: "([^"]*)"$/ do |file|
  date = Date.today
  if file.length > 12
    filename = "Mosaics-#{date}.csv"
  elsif file.length <= 12
    filename = "All_Mosaics-#{date}.csv"
  end
  page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end
