Given /^the following images exist:$/ do |table|
	table.hashes.each do |mosaic|
		Mosaic.new(:steps => mosaic[:steps],
				 :grid => mosaic[:grid]).save!
	end
end

When (/^I follow the link mosaic(.*)$/) do |mosaic_id|
    click_link("Mosaic ##{mosaic_id}")
end

When /^(?:|I )check download box for mosaic with grid: "([^"]*)"$/ do |grid|
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
