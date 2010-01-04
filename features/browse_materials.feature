Feature: browse materials
  In order to see what materials can be recycled
  As a logged out user
  I want to be able to navigate lists of materials
  
  Scenario: finding a material to recycle
    Given I am on the homepage
    And I am not logged in
    Then I should see "RECYCLE"
    And I should see "REDUCE & REUSE" 
    And I should see "YARD WASTE"
    And I should see "HAZARDOUS WASTE"
    And I should see "ELECTRONICS"
    And I should see "TRASH"
    When I follow "TRASH"
    Then I should see "Asphalt"
    When I follow "Asphalt"
    Then I should be on the material page for "Asphalt"
    And I should see "Where to bring this material"
    
   
  
  
