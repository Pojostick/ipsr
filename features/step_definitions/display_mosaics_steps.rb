When /I check the following mosaic result: mosaic(.*)/ do |mosaic_id|
    check("checkbox_#{mosaic_id}")
end