module Ssllabs
  class Chain < ApiObject
    has_objects_list :certs, ChainCert
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
