module KeyboardMagician
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
end
