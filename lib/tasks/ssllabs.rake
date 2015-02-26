require 'ssllabs'

namespace :ssllabs do
  desc "Query information"
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

  desc "Interact with Qualys SSLLabs API"
  task :analyze do
    unless ENV['HOST']
      puts "Specific HOST=... as environment variable"
      next
    end
    api = Ssllabs::Api.new
    r = api.analyse(host: ENV['HOST'],
        publish: 'off', startNew: 'on', all: 'done')
    puts JSON.generate(r)
    puts "Running assessments: #{api.current_assessments}/#{api.max_assessments}"
  end
end
