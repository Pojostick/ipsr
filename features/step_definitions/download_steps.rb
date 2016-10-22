Given(/^the following images exist:$/) do |table|
    table.hashes.each do |mosaic|
        Mosaic.create(mosaic)
    end
  # table is a Cucumber::MultilineArgument::DataTable
end

Given(/^I'm on the image page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
