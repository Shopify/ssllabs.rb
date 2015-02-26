module Ssllabs
  class Host < ApiObject
    has_fields :host,
      :port,
      :protocol,
      :isPublic?,
      :status,
      :statusMessage,
      :startTime,
      :testTime,
      :engineVersion,
      :criteriaVersion,
      :cacheExpiryTime
    has_objects_list :endpoints, Endpoint
    has_fields :certHostnames
  end
end
