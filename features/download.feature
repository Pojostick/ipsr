  
Feature: download current section of completed tests
  
  As a researcher
  So that I can save copies of the tests in my hard drive
  I want to dowload the currently selected image 
  
Background: images have been added in images folder
  Given the following images exist:
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

Scenario: downloading the image
  Given I am on the page for mosaic1
  When I press "download"
  Then I should be on the page for mosaic1

