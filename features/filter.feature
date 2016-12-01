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
  When I filter by "completed" and select "90-100" and I filter by "numcolors" and select "2-5" and I filter by "nummoves" and select "2-5" and I filter by "time_total" and select "5-11" and I press "refresh"
  Then I should see mosaics with grid: "#1d5b46"
  And I should not see mosaics with grid: "transparent"
  
Scenario: Filter by task completion and select the incompleted mosaics
  When I filter by "completed" and select "0-5" and I filter by "numcolors" and select "0-1" and I filter by "nummoves" and select "0-1" and I filter by "time_total" and select "0-2" and I press "refresh"
  Then I should not see mosaics with grid: "#1d5b46"
  And I should see mosaics with grid: "transparent"
  