module Ssllabs
  class Chain < ApiObject
    has_objects_list :certs, ChainCert
    has_fields :issues

    def valid?
      issues == 0
    end

    def invalid?
      !valid?
    end
  end
end
