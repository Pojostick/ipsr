Feature: filtering mosaics available in the database 
  
  As a researcher
  So that I can extract detailed data about the designs  
  I want to be able to filter the mosaics by different features
  
Background: images have been added in images folder
  Given the following images exist:
	  | steps                                          `                  | grid             |step_counter|completed|number_of_colors |time_total|
	  | [{:timestamp=>"1479168193064", :tileId=>"2", :color=>"#1d5b46"}]  | #1d5b46          |2           |100      |2                |10        |
	  | []                                                                | transparent      |0           |0        |0                |1         |
  And  I am on the gallery page
  
Scenario: Filter by task completion and select the completed mosaics
  When I filter by "complete"
  And select "90-100"
  And I filter by "colorcount"
  And select "2-5"
  And I filter by "movescount"
  And select "2-5"
  And I filter by "timetaken"
  And select "5-11"
  And I press "refresh"
  Then I should see mosaics with grid: "#1d5b46"
  And I should not see mosaics with grid: "transparent"
  
Scenario: Filter by task completion and select the incompleted mosaics
  When I filter by "Completed"
  And select "0-5"
  And I filter by "colorcount"
  And select "0-1"
  And I filter by "movescount"
  And select "0-1"
  And I filter by "timetaken"
  And select "0-2"
  And I click "refresh"
  Then I should not see mosaics with grid: "#1d5b46"
  And I should see mosaics with grid: "transparent"
  
Scenario: Filter by total number of colors and select no colors is used
  When I filter by "Total number of colors used"
  And select "0"
  Then I should not see mosaics with grid: "#1d5b46"
  And I should see mosaics with grid: "transparent"
  
Scenario: Filter by total number of colors and 1 to 5 different colors are used
  When I filter by "Total number of colors used"
  And select "1 - 5"
  Then I should see mosaics with grid: "#1d5b46"
  And I should not see mosaics with grid: "transparent"
  
Scenario: Filter by number total number of moves, when no move is made
  When I filter by "Total number of moves"
  And select "0"
  Then I should not see mosaics with grid: "#1d5b46"
  And I should see mosaics with grid: "transparent"
  
Scenario: Filter by number total number of moves, when a move is made
  When I filter by "Total number of moves"
  And select "1 - 5"
  Then I should see mosaics with grid: "#1d5b46"
  And I should not see mosaics with grid: "transparent"
  
Scenario: Filter by dominant color was used
  When I filter by "Dominant color used"
  And select "#1d5b46"
  Then I should see mosaics with grid: "#1d5b46"
  And I should not see mosaics with grid: "transparent"
  
Scenario: Filter by dominanth color was used
  When I filter by "Dominant color used"
  And select "#26f027"
  Then I should not see mosaics with grid: "#1d5b46"
  And I should not see mosaics with grid: "transparent"
