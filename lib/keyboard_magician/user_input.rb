module KeyboardMagician
  class UserInput
    def initialize(keys)
      characters = []
      keys.each do |key|
        if key.delete?
          characters.pop
        else
          characters.push key
        end
      end
      self.characters = characters
    end

    def to_s
      # not sure its good to rely on to_s like this,
      # meta-keys that we haven't accounted for come out all funky
      characters.map(&:to_s).join("")
    end

    private

    attr_accessor :characters
  end
end
