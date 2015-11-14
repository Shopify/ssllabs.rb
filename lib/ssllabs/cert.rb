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
      :crlRevocationStatus,
      :ocspRevocationStatus,
      :sha1Hash,
      :pinSha256,
      :sgc?,
      :validationType,
      :issues,
      :sct?

    def valid?
      issues == 0
    end

    def invalid?
      !valid?
    end
  end
end
