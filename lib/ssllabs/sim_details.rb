module Ssllabs
  class SimDetails < ApiObject
    has_objects_list :results, Simulation
  end
end
