module KeyboardMagician
  class Output
    attr_accessor :target_string, :actual_string

    def initialize(target_string, actual_string)
      self.target_string = target_string
      self.actual_string = actual_string
    end

    include Enumerable

    def each
      return to_enum :each unless block_given?
      target_string.chars
                   .zip(actual_string.chars)
                   .each { |target, actual|
                     meaning = if target == actual
                                 :correct
                               elsif actual
                                 :incorrect
                               else
                                 :unattempted
                               end
                     yield target, meaning
                   }
    end
  end
end
