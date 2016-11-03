Feature: check if checkboxes exists
 
  As a researcher
  So that I can operate on multiple images at a time
  I want to be able to select images and navigate pages
  
    
Background: images have been added in images folder
  Given the following images exist:
	  | steps                 | grid                       |
	  | mosaic1               | 01                         |
	  | mosaic2               | 02                         |
	  | mosaic3               | 03                         |
	  | mosaic4               | 04                         |
	  | mosaic5               | 05                         |
	  | mosaic6               | 06                         |
	  | mosaic7               | 07                         |
	  | mosaic8               | 08                         |
	  | mosaic9               | 09                         |
	  | mosaic10              | 10                         |
	  | mosaic11              | 11                         |
	  | mosaic12              | 12                         |
  And  I am on the gallery page
  
Scenario: check boxes exist
    When I check the following mosaic result: mosaic1
    And I press "download_button"
    Then I should be on the gallery page
    
# Scenario: check if pagination exists
#     When I click Next
#     Then I should see "mosaic10"
#     When I click Previous 
#     Then I should see "mosaic1"


