require 'yaml'
config = YAML.load_file './config.yaml'

# send the output to a file that we can see locally, rather than sending to signoz
config['exporters'] = {'file' => {'path' => 'results.json'}}
config['service']['pipelines'].values.each { it['exporters'] = ['file'] }

# make log file paths relative to the current directory
config['receivers'].values.each do |log_receiver|
  log_receiver['include']&.map! { ".#{it}"}
end

# Do not bath results, so we can get quick feedback on changes
config['processors'].delete('batch')
config['service']['pipelines'].values.each { it['processors'].delete('batch') }


file = File.open('./config_for_testing.yaml', 'w')
file.puts config.to_yaml
file.close
