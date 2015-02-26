module Ssllabs
  class Protocol < ApiObject
    has_fields :id,
      :name,
      :version,
      :v2SuitesDisabled?,
      :q

    def insecure?
      q == 0
    end

    def secure?
      !insecure?
    end
  end
end
