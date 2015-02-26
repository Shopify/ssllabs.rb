module Ssllabs
  class ChainCert < ApiObject
    has_fields :subject,
      :label,
      :issuerSubject,
      :issuerLabel,
      :issues,
      :raw

    def valid?
      issues == 0
    end

    def invalid?
      !valid?
    end
  end
end
