# Given(/^the following images exist:$/) do |table|
#     pending
#     # table.hashes.each do |mosaic|
#     #     Mosaic.create(mosaic)
#     # end
#   # table is a Cucumber::MultilineArgument::DataTable
# end
When (/^I follow the link mosaic(.*)$/) do |mosaic_id|
    click_link("Mosaic ##{mosaic_id}")
end