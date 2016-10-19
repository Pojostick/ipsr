Feature:  Prevent same user from being logged twice
  
  As a researcher 
  So I keep the consistency of the data
  I want to collect the first completed data from the same user
  
Background: test subject has finished a game and is trying to log in again
   Given I have a "play a game" page cookie set to "Name=foo"
   And I have already finished a game with result: "first_result"
   
Scenario: try to play again with same cookie
   When I go to the "play a game" page with cookie: "Name=foo"
   Then I should see "You have already finished the game once. Future results won't be recorded."
   And I should be able to play the game again to get a new result:"second_result"
   And I should not see "second_result" in the gallery
   