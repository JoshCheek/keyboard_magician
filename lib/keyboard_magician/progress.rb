module KeyboardMagician
  module Progress
    extend self

    def self.result_for_chars(target_char, actual_char)
      return :correct     if target_char == actual_char
      return :incorrect   if actual_char
      return :unattempted
    end

    def self.call(target_string, actual_string)
      progress_for(target_string, actual_string)
    end

    def progress_for(target_string, actual_string)
      target_string.each_char
                   .zip(actual_string.each_char)
                   .map { |target, actual| [target, Progress.result_for_chars(target, actual)] }
    end
  end
end
