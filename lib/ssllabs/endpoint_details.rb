module Ssllabs
  class EndpointDetails < ApiObject
    has_fields :hostStartTime
    has_object_ref :key, Key
    has_object_ref :cert, Cert
    has_object_ref :chain, Chain
    has_objects_list :protocols, Protocol
    has_object_ref :suites, Suites
    has_fields :serverSignature,
      :prefixDelegation?,
      :nonPrefixDelegation?,
      :vulnBeast?,
      :renegSupport,
      :stsResponseHeader,
      :stsMaxAge,
      :stsSubdomains?,
      :pkpResponseHeader,
      :sessionResumption,
      :compressionMethods,
      :supportsNpn?,
      :npnProtocols,
      :sessionTickets,
      :ocspStapling?,
      :staplingRevocationStatus,
      :staplingRevocationErrorMessage,
      :sniRequired?,
      :httpStatusCode,
      :httpForwarding,
      :supportsRc4?,
      :stsStatus,
      :stsPreload,
      :hstsPolicy,
      :hstsPreloads,
      :hpkpPolicy,
      :hpkpRoPolicy,
      :rc4Only,
      :preloadChecks,
      :forwardSecrecy,
      :rc4WithModern?,
      :drownHosts,
      :drownErrors,
      :drownVulnerable?
    has_object_ref :sims, SimDetails
    has_fields :heartbleed?,
      :heartbeat?,
      :openSslCcs,
      :poodleTls,
      :fallbackScsv?,
      :poodle?,
      :freak?,
      :hasSct,
      :dhPrimes,
      :dhUsesKnownPrimes,
      :dhYsReuse?,
      :logjam?
  end
end
