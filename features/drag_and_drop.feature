Feature: drag and drop blocks
  As a test subject
  So I can change my favorite color pattern
  I want to drag colored blocks

Background: test subject is testing
  Given I am on the grid
  And the first color in the palette is color "red"
  And the second color in the palette is color "blue"
  Then I should see an 8 by 10 grid

Scenario: drag from palette to grid
  When I drag the first color to grid location (5, 7)
  Then I should see the color "red" in grid location (5, 7)
  
Scenario: drag from palette to palette
  When I drag the first color to the second color
  Then I should see the color "red" in the first color
  And I should see the color "blue" in the second color
  
Scenario: drag from grid to grid
  When I drag the first color to grid location (5, 7)
  And I drag the second color to grid location (2, 1)
  And I drag grid location (5, 7) to grid location (2, 1)
  Then I should see "blue" in grid location (5, 7)
  And I should see "red" in grid location (2, 1)