Feature: Simple game
  The intermediate form of playing this game is to type out sentences and shit.
  We'll call this a simple game.

  Scenario: Type everything correctly
    Given my target is "abc def"
    And it takes me 5s to play the game
    When I type the characters: [:a], [:b], [:c], [:" "], [:d], [:e], [:f]
    Then the game is over
    And it took me 5s to play the game
    And my cps is 1.4
    And I have 0 errors

  Scenario: An error
    Given my target is "abc"
    When I type the characters: [:a], [:x], [:c]
    Then the game is over
    And I have 1 errors

  Scenario: Deleting a character
    Given my target is "abc"
    When I type the characters: [:a], [:x], [:delete], [:b], [:c]
    Then the game is over
    And I have 0 errors

