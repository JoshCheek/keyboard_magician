module KeyboardMagician
  module Console
    module ParseKey
      extend self
      def self.call(char)
        parse_key char
      end

      def parse_key(char)
        return [:up    ] if char == "\e[A"
        return [:down  ] if char == "\e[B"
        return [:right ] if char == "\e[C"
        return [:left  ] if char == "\e[D"
        return [:delete] if char == "\u007F"
        [char.intern]
      end
    end
  end
end
