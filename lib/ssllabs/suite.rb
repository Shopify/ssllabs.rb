module Ssllabs
  class Suite < ApiObject
    has_fields :id,
      :name,
      :cipherStrength,
      :dhStrength,
      :dhP,
      :dhG,
      :dhYs,
      :ecdhBits,
      :ecdhStrength,
      :q

    def insecure?
      q == 0
    end

    def secure?
      !insecure?
    end
  end
end
