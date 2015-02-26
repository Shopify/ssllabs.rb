module Ssllabs
  class Key < ApiObject
    has_fields :size,
      :strength,
      :alg,
      :debianFlaw?,
      :q

    def insecure?
      debian_flaw? || q == 0
    end

    def secure?
      !insecure?
    end
  end
end
