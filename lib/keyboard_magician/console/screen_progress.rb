module KeyboardMagician
  module Console
    module ScreenProgress
      extend self

      def self.call(progress_ary)
        screen_progress progress_ary
      end

      def screen_progress(progress_ary)
        progress_ary.map { |char, result|
          if result == :correct
            "\e[30;42m#{char}"
          elsif result == :incorrect
            "\e[37;41m#{char}"
          else
            "\e[0m#{char}"
          end
        }.join("")
      end
    end
  end
end
