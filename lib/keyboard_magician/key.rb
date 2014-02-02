module KeyboardMagician
  class Key
    attr_accessor :key, :metas

    def initialize(key, *metas)
      self.key   = key
      self.metas = metas
    end

    # not good to rely on this, b/c meta keys don't have a valid representation
    def to_s
      key.to_s
    end

    def delete?
      key == :delete
    end
  end
end
