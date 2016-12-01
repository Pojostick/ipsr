  
Feature: download current section of completed tests
  
  As a researcher
  So that I can save copies of the tests in my hard drive
  I want to dowload the currently selected image 
  
Background: images have been added in images folder
  Given the following images exist:
	  | steps                                          `                  | grid                    |step_counter|completed|number_of_colors |dominant_color|
	  | [{:timestamp=>"1479168193064", :tileId=>"2", :color=>"#1d5b46"}]  | #7b3a42 #d6b027 #982b31 |1           |true     |3                |#1d5b46       |
	  | []                                                                | transparent             |0           |false    |0                |              |
  And  I am on the gallery page

Scenario: redirect to gallery page if clicking the download selected without selecting any box
  When I press "Download selected"
  Then I am on the gallery page
  
Scenario: selecting image to be downloaded
  When I check download box for mosaic with grid: "#7b3a42 #d6b027 #982b31"
  And I press "Download selected"
  Then I should be able to download the file with file name: "selected_mosaics"
  
Scenario: dowload all images
  When I press "Download all"
  Then I should be able to download the file with file name: "all_mosaics"
 