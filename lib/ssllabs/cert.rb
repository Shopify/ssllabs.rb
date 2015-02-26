module Ssllabs
  class Cert < ApiObject
    has_fields :subject,
      :commonNames,
      :altNames,
      :notBefore,
      :notAfter,
      :issuerSubject,
      :sigAlg,
      :issuerLabel,
      :revocationInfo,
      :crlURIs,
      :ocspURIs,
      :revocationStatus,
      :sgc?,
      :validationType,
      :issues

    def valid?
      issues == 0
    end

    def invalid?
      !valid?
    end
  end
end
