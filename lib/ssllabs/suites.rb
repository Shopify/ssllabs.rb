module Ssllabs
  class Suites < ApiObject
    has_objects_list :list, Suite
    has_fields :preference?
  end
end
