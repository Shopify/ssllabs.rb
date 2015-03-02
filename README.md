# ssllabs.rb

Ruby gem for Qualys SSL Labs server test.

## API Notes

* All API objects described in the [SSL Labs API docs](https://github.com/ssllabs/ssllabs-scan/blob/master/ssllabs-api-docs.md) are exposed as native ruby objects.
* Properties are accessed with "underscored" names, i.e. `endpoint.host_start_time` will return the `hostStartTime` field from the API response.
* All boolean properties are suffixed with the `?` symbol, so `endpoint.vuln_beast?` will return the `vulnBeast` field from the API response.
* After each successful request, the latest values for the `X-Max-Assessments` and `X-Current-Assessments` headers are available at `api.current_assessments` and `api.max_assessments`.

## Install it

Add the following line to your Gemfile:
```ruby
gem 'ssllabs', github: 'Shopify/ssllabs.rb', require: 'ssllabs'
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

$ rake ssllabs:endpoint_data HOST=www.shopify.com IP=107.20.198.159
{"ipAddress":"107.20.198.159","serverName":"ec2-107-20-198-159.compute-1.amazonaws.com","statusMessage":"Ready","statusDetails":null,"statusDetailsMessage":null,"grade":"A","hasWarnings":false,"isExceptional":false,"progress":100,"duration":81260,"eta":18,"delegation":2,"details":{"hostStartTime":1424965787916,"key":{"size":2048,"strength":2048,"alg":"RSA","debianFlaw":false,"q":null},"cert":{"subject":"CN=www.shopify.com,O=Shopify Inc.,ST=Ontario,L=Ottawa,C=CA,2.5.4.17=#13074b314e20355435,STREET=126 York Street,STREET=Suite 200,2.5.4.5=#130734323631363037,1.3.6.1.4.1.311.60.2.1.3=#13024341,2.5.4.15=#0c1450726976617465204f7267616e697a6174696f6e","commonNames":["www.shopify.com"],"altNames":["www.shopify.com","www.shopify.ca","www.shopify.co.nz","fr.shopify.com","pt.shopify.com","es.shopify.com","hi.shopify.com","ru.shopify.com","www.shopify.in","www.shopify.co.za","www.shopify.com.sg","shopify.com","www.shopify.co.id","www.shopify.co.uk","www.shopify.com.au","www.shopify.my","shopify.ca","shopify.co.nz","shopify.in","shopify.co.za","shopify.com.sg","shopify.co.id","shopify.co.uk","shopify.com.au","shopify.my"],"notBefore":1384387200000, ...[etc]
Running assessments: 0/25
```
