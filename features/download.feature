  
Feature: download current section of completed tests
  
  As a researcher
  So that I can save copies of the tests in my hard drive
  I want to dowload the currently selected image 
  
Background: images have been added in images folder
  Given the following images exist:
	  | steps                 | grid                       |
	  | mosaic1               | 01                         |
	  | mosaic2               | 02                         |
  And  I am on the gallery page

Scenario: selecting image to be downloaded
  When I follow "mosaic1"
#   Then I should be on the mosaic page
#   When I follow "mosaic2"
#   Then I should be on the mosaic page

# Scenario: downloading the image
#   Given I'm on the image page
#   When I press "download"
#   Then I should be on the mosaic page
	
