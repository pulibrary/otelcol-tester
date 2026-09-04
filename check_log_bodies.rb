require 'json'

lines = File.readlines './results.json'
log_entries = lines
  .map { JSON.parse(it)['resourceLogs'] }
  .compact
  .flatten
  .map { it['scopeLogs'] }
  .flatten
  .map { it['logRecords'] }
  .flatten

puts "Found #{log_entries.count} entries"
puts "They are:"
log_entries.each { puts "[#{it['severityText']} #{it['severityNumber']}]: #{it['body']['stringValue'][..100]}" }
