Feature:  Prevent same user from being logged twice
  
  As a researcher 
  So I keep the consistency of the data
  I want to collect the first completed data from the same user
  
Background: test subject has finished a game and is trying to log in again
   Given I am on the login page
   And I have already logged in with username: "cloud7"
   
Scenario: try to log in with same username
   When I type in with username: "cloud7"
   And I press "log in"
   Then I should see "cloud7 has already logged in. The new game result won't be recorded."
   And I should be able to play the game again to get a new result:"my result"
   And I should not see "my result" in the gallery
   