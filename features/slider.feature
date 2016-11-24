Feature: The single mosaic page can use slider to show the construction process
  
  As a researcher
  So that I can extract detailed data about the designs
  I want to see the mosiacs construction process
  
  
Background: images have been added in images folder
  Given the following images exist:
	  | steps                                          `                  | grid                    |
	  | [{:timestamp=>"1479168193064", :tileId=>"2", :color=>"#1d5b46"}]  | #7b3a42 #d6b027 #982b31 |
	  | []                                                                | transparent             |
  And  I am on the mosaic page with id: 1
  
Scenario: Drag the slider to see the construction process
  When I hold on the slider
  And I drag it
  Then I should see a tile of color: "#7b3a42" moves to grid position: 2