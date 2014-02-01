module InterpretCharacter
  extend self
  def self.call(char)
    interpret_character char
  end

  def interpret_character(char)
    return [:up    ] if char == "\e[A"
    return [:down  ] if char == "\e[B"
    return [:right ] if char == "\e[C"
    return [:left  ] if char == "\e[D"
    return [:delete] if char == "\u007F"
    [char.intern]
  end
end
