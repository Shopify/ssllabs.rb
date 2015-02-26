module Ssllabs
  class Simulation < ApiObject
    has_object_ref :client, SimClient
    has_fields :errorCode,
      :attempts,
      :protocolId,
      :suiteId

    def success?
      error_code == 0
    end

    def error?
      !success?
    end
  end
end
