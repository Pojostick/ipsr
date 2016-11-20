  
Feature: download current section of completed tests
  
  As a researcher
  So that I can save copies of the tests in my hard drive
  I want to dowload the currently selected image 
  
Background: images have been added in images folder
  Given the following images exist:
<<<<<<< HEAD
	  | steps                 | grid                        |id
	  | mosaic1               | #01                         |01
	  | mosaic2               | #02                         |02
  And  I am on the gallery page

Scenario: selecting image to be downloaded
  When I click on the following link "mosaic1"
  Then I should be on the page for mosaic1
  When  I am on the gallery page
  And I click on the following link "mosaic2"
  Then I should be on the page for mosaic2
# Background: images have been added in images folder
#   Given the following images exist:
# 	  | steps                 | grid                       |
# 	  | mosaic1               | 01                         |
# 	  | mosaic2               | 02                         |
#   And  I am on the gallery page

# Scenario: selecting image to be downloaded
#   When I follow "mosaic1"
#   Then I should be on the page for mosaic1
#   When  I am on the gallery page
#   And I follow "mosaic2"
#   Then I should be on the page for mosaic2

# Background: images have been added in images folder
#   Given the following images exist:
# 	  | steps                 | grid                       |
# 	  | mosaic1               | 01                         |
# 	  | mosaic2               | 02                         |
#   And  I am on the gallery page
	  |id| steps                                                                      | grid                          |
	  |1 | "1477438484929 0 #7b3a42,1477438486424 1 #d6b027,1477438487938 2 #982b31," | "#7b3a42 #d6b027 #982b31"     |
	  |2 | "1477439804182 1 #d6b027,1477439805097 2 #73a373,"                         | "transparent #d6b027 #73a373" |
  And  I am on the gallery page

Scenario: selecting image to be downloaded
  When I check download box: mosaic1
  And I click the "dowload selected" button
  Then I should be able to download the mosaic1.csv
  
Scenario: dowload all images
  When I click the "download all" button
  Then I should be able to download the mosaic1.csv
  Then I should be able to download the mosaic2.csv
  
  
  
  # Scenario: selecting image to be downloaded
#   When I follow "mosaic1"
#   Then I should be on the page for "mosaic1"
#   When  I am on the gallery page
#   And I follow "mosaic2"
#   Then I should be on the page for "mosaic2"

# Scenario: downloading the image
#   Given I am on the page for mosaic1
#   When I press "download"
#   Then I should be on the page for mosaic1
  