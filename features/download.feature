  
Feature: download current section of completed tests
  
  As a researcher
  So that I can save copies of the tests in my hard drive
  I want to dowload the currently selected image 
  
Background: images have been added in images folder
  
	Given the following images in image folder
  	| file name               | 
  	| image1.png           	  |
 
  	And  I am on the galleries page

Scenario: opening a dialog box and rename image
	When I click download on "image1.png"
	And I fill in "new img name" in "save"
	Then I should get "new img name.png" file 
	And I should be on the same page
