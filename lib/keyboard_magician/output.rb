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
      target_string.each_char
                   .zip(actual_string.each_char)
                   .each { |target, actual|
                     yield target, result(target, actual)
                   }
    end

    private

    def result(target_char, actual_char)
      return :correct     if target_char == actual_char
      return :incorrect   if actual_char
      return :unattempted
    end
  end
end
