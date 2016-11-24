Feature: Oauth logins
  As a researcher
  I don't want anyone to see mosaics created by others
  I want logins to be required

Background: I have not yet logged in
  Given that I am not logged in
  Then I should see the login page
  And then if I log in
  Then I should be able to see the main page

Scenario: I am viewing the gallery
  Given the following images exist:
	  | steps                                          `                  | grid                    |
	  | [{:timestamp=>"1479168193064", :tileId=>"2", :color=>"#1d5b46"}]  | #7b3a42 #d6b027 #982b31 |
	  | []                                                                | transparent             |
  And  I am on the gallery page
  Then I should see no image that belongs to someone else