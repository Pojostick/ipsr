Feature: take a pre-mosaic-test survey
  As a test subject
  So I can provide valuable pre-test data to researchers
  I must take a pre-test survey

Background: questions in survey
  Given the following questions exist:
    | question  | format     | choices                               |
    | Gender?   | MultChoice | M, F, Apache Attack Helicopter, Other |
    | Type      | CheckBox   | Automaton, Human, Other               |

Scenario: survey questions exist
  Given I am on the survey page for question 1
  Then I should see the following: "Gender?", "M", "F", "Apache Attack Helicopter", "Other"
  And I should see "Next"
  But I should not see "Back"

Scenario: survey questions save state
  Given I am on the survey page for question 2
  And I check the following: "Automaton", "Human"
  And I go to question 1
  And I go to question 2
  Then I should see the following checked: "Automaton", "Human"
  
Scenario: survey finishes
  Given I am on the survey page for question 2
  And I press "Begin Mosaic Test"
  Then I should be on the grid
