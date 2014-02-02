module KeyboardMagician
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
end
