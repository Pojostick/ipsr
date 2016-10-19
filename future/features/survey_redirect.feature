Feature: Mosaic Construction Test: Redirect to survey before test
  As a test subject
  So I can provide valuable pre-test data to researchers
  I should be able to start a survey before the test

Background: questions in survey
  Given I am on the mosiac test home page

Scenario: start the pre-test survey, if it has never been taken
  And I have not taken the survey before
  Then I should see "Begin Test"
  When I press "Begin Test"
  Then I should be on the survey page

Scenario: start the pre-test survey, if it has been taken
  And I have taken the survey before
  Then I should see "Begin Mosaic Test"
  When I press "Begin Mosaic Test"
  Then I should be on the grid
