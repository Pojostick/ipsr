Feature: show completed mosaic construction tests
    As an person interested in personality and social research
    So I can satisfy my interest
    I want to see the completed mosaic construction tests

Background: viewer on the gallery home page
    Given I am on the gallery page

# Scenario: completed tests are displayed
#     Then I should see images

# Scenario: can view completed test in detail
#     When I click on test 1
#     Then I should be on the test 1 display page
    
Scenario: only view dates when ranges are selected
    When I select a date ranging from 2016 to 2016
    Then I should only see mosaics ranging from 2016 to 2016