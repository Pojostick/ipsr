
Given(/^the following images exist:$/) do |table|
    table.hashes.each do |mosaic|
        Mosaic.create(mosaic)
    end
  # table is a Cucumber::MultilineArgument::DataTable
end
When (/^I click on the following link (.*)$/) do |mosaic|
    mosaic_id = Mosaic.find_by_steps(mosaic)
end

# Given(/^the following images exist:$/) do |table|
#     pending
#     # table.hashes.each do |mosaic|
#     #     Mosaic.create(mosaic)
#     # end
#   # table is a Cucumber::MultilineArgument::DataTable
# end

# When (/^I follow the link mosaic(.*)$/) do |mosaic_id|
#     click_link("Mosaic ##{mosaic_id}")
# end

When (/^I follow the link mosaic(.*)$/) do |mosaic_id|
    click_link("Mosaic ##{mosaic_id}")
end

