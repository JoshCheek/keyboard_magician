class Game
  attr_accessor :target_string, :user_input

  def initialize(attributes={})
    self.target_string = attributes[:target_string] || ''
    self.user_input    = attributes[:user_input]    || UserInput.new([])
  end

  def user_enters(character)
    Game.new target_string: target_string,
             user_input:    user_input.push(character)
  end
end

class UserInput
  def initialize(characters)
    self.characters = characters
  end

  def push(character)
    self.class.new(characters + [character])
  end

  def to_s
    characters.map(&:to_s).join("")
  end

  private
  attr_accessor :characters
end

class MockTimer
  attr_accessor :time_taken

  def initialize(time_taken)
    self.time_taken = time_taken
  end
end

class Character
  attr_accessor :key, :metas
  def initialize(key, *metas)
    self.key   = key
    self.metas = metas
  end

  def to_s
    key.to_s
  end
end

class GameStats
  def initialize(game: game, timer: timer)
    self.game  = game
    self.timer = timer
  end

  def over?
    target_size == actual_size
  end

  def time_taken
    timer.time_taken
  end

  def cps
    target_size / time_taken
  end

  def num_errors
    0 # probably need a real algorithm for this like... uhm, markov distane I think its called? (no internet right now to look it up)
  end

  private

  def target_size
    game.target_string.size
  end

  def actual_size
    game.user_input.to_s.size
  end

  attr_accessor :game, :timer
end
