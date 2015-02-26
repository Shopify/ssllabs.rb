# ssllabs.rb

Ruby gem for Qualys SSL Labs server test.

## API Notes

* All API objects described in the [SSL Labs API docs](https://github.com/ssllabs/ssllabs-scan/blob/master/ssllabs-api-docs.md) are exposed as native ruby objects.
* Properties are accessed with "underscored" names, i.e. `endpoint.host_start_time` will return the `hostStartTime` field from the API response.
* All boolean properties are suffixed with the `?` symbol, so `endpoint.vuln_beast?` will return the `vulnBeast` field from the API response.

## Install it

Add the following line to your Gemfile:
```ruby
gem github: 'Shopify/ssllabs.rb', require: 'ssllabs'
```

## Use it (as a gem)

```ruby
require 'ssllabs'

api = Ssllabs::Api.new
info = api.info

puts "Engine version: #{info.engine_version}"
puts "Evaluation criteria: #{info.criteria_version}"
puts "Running assessments: #{info.current_assessments} (max #{info.max_assessments})"
```

## Use it (standalone)

A few rake tasks are available to assist in manually testing sites. They return JSON responses.

```
$ rake ssllabs:info
{"engineVersion":"1.13.14","criteriaVersion":"2009i","clientMaxAssessments":25,"maxAssessments":25,"currentAssessments":0,"messages":["This assessment service is provided free of charge by Qualys SSL Labs, subject to our terms and conditions: https://dev.ssllabs.com/about/terms.html"]}
Running assessments: 0/25

$ rake ssllabs:status_codes
{"statusDetails":{"TESTING_PROTOCOL_INTOLERANCE_399":"Testing Protocol Intolerance (TLS 1.99)","PREPARING_REPORT":"Preparing the report","TESTING_SESSION_RESUMPTION":"Testing session resumption","TESTING_NPN":"Testing NPN", ...[etc]
Running assessments: 0/25

$ rake ssllabs:analyze HOST=www.shopify.com
{"host":"www.shopify.com","port":443,"protocol":"HTTP","isPublic":true,"status":"DNS","statusMessage":"Resolving domain names","startTime":1424965787916,"testTime":null,"engineVersion":"1.13.14","criteriaVersion":"2009i","cacheExpiryTime":null,"endpoints":null,"certHostnames":null}
Running assessments: 0/24

[wait a few seconds]

$ rake ssllabs:analyze HOST=www.shopify.com
{"host":"www.shopify.com","port":443,"protocol":"HTTP","isPublic":true,"status":"IN_PROGRESS","statusMessage":null,"startTime":1424965787916,"testTime":null,"engineVersion":"1.13.14","criteriaVersion":"2009i","cacheExpiryTime":null,"endpoints":[{"ipAddress":"107.20.160.121","serverName":"ec2-107-20-160-121.compute-1.amazonaws.com","statusMessage":"In progress","statusDetails":"TESTING_RENEGOTIATION","statusDetailsMessage":"Testing renegotiation","grade":null,"hasWarnings":null,"isExceptional":null,"progress":-1,"duration":null,"eta":-1,"delegation":1,"details":null},{"ipAddress":"50.16.198.238","serverName":"ec2-50-16-198-238.compute-1.amazonaws.com","statusMessage":"Pending","statusDetails":null,"statusDetailsMessage":null,"grade":null,"hasWarnings":null,"isExceptional":null,"progress":-1,"duration":null,"eta":-1,"delegation":2,"details":null},{"ipAddress":"107.20.198.159","serverName":"ec2-107-20-198-159.compute-1.amazonaws.com","statusMessage":"Pending","statusDetails":null,"statusDetailsMessage":null,"grade":null,"hasWarnings":null,"isExceptional":null,"progress":-1,"duration":null,"eta":-1,"delegation":2,"details":null},{"ipAddress":"107.20.160.98","serverName":"ec2-107-20-160-98.compute-1.amazonaws.com","statusMessage":"Pending","statusDetails":null,"statusDetailsMessage":null,"grade":null,"hasWarnings":null,"isExceptional":null,"progress":-1,"duration":null,"eta":-1,"delegation":1,"details":null}],"certHostnames":null}
Running assessments: 1/24
```
