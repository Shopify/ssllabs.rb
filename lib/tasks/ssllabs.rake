require 'ssllabs'

namespace :ssllabs do
  desc "Retrieve API information"
  task :info do
    api = Ssllabs::Api.new
    puts api.info.to_json
    puts "Running assessments: #{api.current_assessments}/#{api.max_assessments}"
  end

  desc "Retrieve error messages"
  task :status_codes do
    api = Ssllabs::Api.new
    puts api.get_status_codes.to_json
    puts "Running assessments: #{api.current_assessments}/#{api.max_assessments}"
  end

  desc "Start analysis for a host"
  task :analyze do
    unless ENV['HOST']
      puts "Specify HOST=... as environment variable"
      next
    end
    api = Ssllabs::Api.new
    r = api.analyse(host: ENV['HOST'],
        publish: 'off', startNew: 'on', all: 'done')
    puts JSON.generate(r)
    puts "Running assessments: #{api.current_assessments}/#{api.max_assessments}"
  end

  desc "Retrieve endpoint data from cache"
  task :endpoint_data do
    unless ENV['HOST'] && ENV['IP']
      puts "Specify HOST=... and IP=... as environment variable"
      next
    end
    api = Ssllabs::Api.new
    r = api.get_endpoint_data(host: ENV['HOST'],
        s: ENV['IP'], fromCache: 'on')
    puts JSON.generate(r)
    puts "Running assessments: #{api.current_assessments}/#{api.max_assessments}"
  end
end
