Feature:  Prevent same user from being logged twice
  
  As a researcher 
  So I keep the consistency of the data
  I want to collect the first completed data from the same user
  
Background: test subject has finished a game and is trying to log in again
#   Given I am on the grid
#   And The cookie of this page is stored as: "logged_in_cookies"
#   And I have already finished a game with result with id: "mosaic_id"
   
Scenario: try to play again with same cookie
#   When I am on the grid
#   And The cookie "logged_in_cookies" is already existed
#   Then I should see "You have already finished the game once. Future results won't be recorded."
#   And I should be able to play the game again to get a new result with id: "mosaic_id"
#   And I should not see "second_result" in the gallery 
   