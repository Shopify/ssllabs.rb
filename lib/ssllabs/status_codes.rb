module Ssllabs
  class StatusCodes < ApiObject
    has_fields :statusDetails

    def [](name)
      status_details[name]
    end
  end
end
