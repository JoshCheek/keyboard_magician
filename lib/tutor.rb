class Character
  attr_accessor :key, :metas
  def initialize(key, *metas)
    self.key   = key
    self.metas = metas
  end

  def to_s
    key.to_s
  end

  def delete?
    key == :delete
  end
end

class UserInput
  def initialize(characters)
    _characters = []
    characters.each do |character|
      if character.delete?
        _characters.pop
      else
        _characters << character
      end
    end
    self.characters = _characters
  end

  def to_s
    characters.map(&:to_s).join("")
  end

  private

  attr_accessor :characters
end

# UNTESTED
require 'time'
class Timer
  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  def seconds_taken
    (@stop_time - @start_time).to_f
  end
end

class MockTimer
  attr_accessor :seconds_taken

  def initialize(seconds_taken)
    self.seconds_taken = seconds_taken
  end
end

class GameStats
  def initialize(attributes)
    self.target_string = attributes.fetch :target_string
    self.input_string  = attributes.fetch :input_string
    self.timer         = attributes.fetch :timer
  end

  def over?
    target_string.size == input_string.size
  end

  def seconds_taken
    timer.seconds_taken
  end

  def cps
    target_string.size / seconds_taken
  end

  def num_errors
    # TODO: probably need a real algorithm for this like... uhm, markov distane I think its called? (no internet right now to look it up)
    target_string
      .chars
      .zip(input_string.chars)
      .count { |c1, c2| c1 != c2 }
  end

  private

  attr_accessor :timer, :target_string, :input_string
end
