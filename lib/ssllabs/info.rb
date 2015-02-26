module Ssllabs
  class Info < ApiObject
    has_fields :engineVersion,
      :criteriaVersion,
      :clientMaxAssessments,
      :maxAssessments,
      :currentAssessments,
      :messages
  end
end
