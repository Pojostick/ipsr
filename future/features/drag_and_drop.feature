Feature: drag and drop blocks
  As a test subject
  So I can change my favorite color pattern
  I want to drag colored blocks

Background: test subject is testing
  Given I am on the grid
  And color 0 in the palette is the color "red"
  And color 1 in the palette is the color "blue"
  Then I should see an 8 by 10 grid
  
Scenario: drag from palette to grid
  When I drag color 0 to grid location (5, 7)
  Then I should see the color "red" in grid location (5, 7)
  
@javascript
Scenario: drag from palette to palette
  When I drag color 0 to color 1
  Then I should see the color "red" in color 0
  And I should see the color "blue" in color 1
  
@javascript
Scenario: drag from grid to grid
  When I drag color 0 to grid location (5, 7)
  And I drag color 1 to grid location (2, 1)
  And I drag grid location (5, 7) to grid location (2, 1)
  Then I should see color "blue" in grid location (5, 7)
  And I should see color "red" in grid location (2, 1)