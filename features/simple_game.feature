Feature: Simple game
  The intermediate form of playing this game is to type out sentences and shit.
  We'll call this a simple game.

  Scenario: Type everything correctly
    Given my target is "abc def"
    And it takes me 5s to play the game
    When I press the keys: [:a], [:b], [:c], [:" "], [:d], [:e], [:f]
    Then the game is over
    And it took me 5s to play the game
    And my cps is 1.4
    And my wpm is 16.8
    And I have 0 errors

  Scenario: An error
    Given my target is "abc"
    When I press the keys: [:a], [:x], [:c]
    Then the game is over
    And I have 1 errors

  Scenario: Fixing an error with delete
    Given my target is "abc"
    When I press the keys: [:a], [:x], [:delete], [:b], [:c]
    Then the game is over
    And I have 0 errors

  Scenario: Printing progress
    Given my target is "abc"
    When I press the keys: [:a]
    Then the output shows:
    | character | meaning     |
    | "a"       | correct     |
    | "b"       | unattempted |
    | "c"       | unattempted |
    When I press the keys: [:x]
    Then the output shows:
    | character | meaning     |
    | "a"       | correct     |
    | "b"       | incorrect   |
    | "c"       | unattempted |
    When I press the keys: [:delete]
    Then the output shows:
    | character | meaning     |
    | "a"       | correct     |
    | "b"       | unattempted |
    | "c"       | unattempted |
    When I press the keys: [:b], [:c]
    Then the output shows:
    | character | meaning |
    | "a"       | correct |
    | "b"       | correct |
    | "c"       | correct |
