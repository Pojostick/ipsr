Feature: filtering mosaics available in the database 
  
  As a researcher
  So that I can extract detailed data about the designs  
  I want to be able to filter the mosaics by different features
  
Background: images have been added in images folder
  Given the following images exist:
	  | steps                                          `                  | grid                    |
	  | [{:timestamp=>"1479168193064", :tileId=>"2", :color=>"#1d5b46"}]  | #7b3a42 #d6b027 #982b31 |
	  | []                                                                | transparent             |
  And  I am on the gallery page
  
Scenario: Filter by task completion and select the completed mosaics
  When I filter by "Task completion"
  And select "completed"
  Then I should see mosaics with grid "#7b3a42 #d6b027 #982b31"
  And I should see mosaics with grid "transparent "
  
Scenario: Filter by task completion and select the incompleted mosaics
  When I filter by "Task completion"
  And select "completed"
  Then I should not see mosaics with grid "#7b3a42 #d6b027 #982b31"
  And I should not see mosaics with grid "transparent "
  
Scenario: Filter by total number of colors and select no colors is used
  When I filter by "Number of colors"
  And select "No colors"
  Then I should not see mosaics with grid "#7b3a42 #d6b027 #982b31"
  And I should see mosaics with grid "transparent "
  
Scenario: Filter by total number of colors and 1 to 5 different colors are used
  When I filter by "Number of colors"
  And select "1 - 5"
  Then I should see mosaics with grid "#7b3a42 #d6b027 #982b31"
  And I should not see mosaics with grid "transparent "
  
Scenario: Filter by number of times each color was used, when a used color is picked
  When I filter by "Number of colors used"
  And select "#d6b027"
  And select "1 - 5 times"
  Then I should see mosaics with grid "#7b3a42 #d6b027 #982b31"
  And I should not see mosaics with grid "transparent "
  
Scenario: Filter by number of times each color was used, when the chosen color is not used 
  When I filter by "Number of colors used"
  And select "#26f027"
  And select "1 - 5 times"
  Then I should not see mosaics with grid "#7b3a42 #d6b027 #982b31"
  And I should not see mosaics with grid "transparent "
  
Scenario: Filter by number total number of moves, when no move is made
  When I filter by "Number of moves"
  And select "0"
  Then I should not see mosaics with grid "#7b3a42 #d6b027 #982b31"
  And I should see mosaics with grid "transparent "
  
Scenario: Filter by number total number of moves, when a move is made
  When I filter by "Number of moves"
  And select "1 - 5"
  Then I should see mosaics with grid "#7b3a42 #d6b027 #982b31"
  And I should not see mosaics with grid "transparent "
