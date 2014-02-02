module KeyboardMagician
  class GameStats
    attr_reader :seconds_taken

    def initialize(attributes)
      self.target_string = attributes.fetch :target_string
      self.input_string  = attributes.fetch :input_string
      self.seconds_taken = attributes.fetch :seconds_taken
      self.seconds_taken = 0.01 if seconds_taken == 0
    end

    def over?
      target_string.size == input_string.size
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

    attr_writer   :seconds_taken
    attr_accessor :timer, :target_string, :input_string
  end
end
