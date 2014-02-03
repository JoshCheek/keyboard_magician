Feature: Simple trick
  A simple show is a show with one trick:
  Write a single sentence correctly and quickly

  Scenario: Type everything correctly
    Given my target is "abc def"
    And it takes me 5s to perform the trick
    When I press the keys: [:a], [:b], [:c], [:" "], [:d], [:e], [:f]
    Then the trick is over
    And it took me 5s to perform the trick
    And my cps is 1.4
    And my wpm is 16.8
    And I have 0 errors

  Scenario: An error
    Given my target is "abc"
    When I press the keys: [:a], [:x], [:c]
    Then the trick is over
    And I have 1 errors

  Scenario: Fixing an error with delete
    Given my target is "abc"
    When I press the keys: [:a], [:x], [:delete], [:b], [:c]
    Then the trick is over
    And I have 0 errors

  Scenario: Printing progress
    Given my target is "abc"
    When I press the keys: [:a]
    Then the output shows:
    | character | result      |
    | "a"       | correct     |
    | "b"       | unattempted |
    | "c"       | unattempted |
    When I press the keys: [:x]
    Then the output shows:
    | character | result      |
    | "a"       | correct     |
    | "b"       | incorrect   |
    | "c"       | unattempted |
    When I press the keys: [:delete]
    Then the output shows:
    | character | result      |
    | "a"       | correct     |
    | "b"       | unattempted |
    | "c"       | unattempted |
    When I press the keys: [:b], [:c]
    Then the output shows:
    | character | result  |
    | "a"       | correct |
    | "b"       | correct |
    | "c"       | correct |
