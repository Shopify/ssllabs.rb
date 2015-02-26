module Ssllabs
  class SimClient < ApiObject
    has_fields :id,
      :name,
      :platform,
      :version,
      :isReference?
  end
end
