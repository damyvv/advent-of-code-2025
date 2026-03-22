#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'fileutils'

def load_env(path)
  return unless File.exist?(path)
  File.readlines(path).each do |line|
    next if line.strip.empty? || line.strip.start_with?('#')
    key, val = line.strip.split('=', 2)
    next unless key && val
    ENV[key] = val.gsub(/\A['\"]|['\"]\z/, '')
  end
end

ROOT = File.expand_path('..', __dir__)
load_env(File.join(ROOT, '.env'))

day_arg = ARGV[0]
year = ARGV[1] || '2025'

unless day_arg && day_arg =~ /\A\d+\z/ && (1..25).cover?(day_arg.to_i)
  warn "Usage: #{$0} DAY [YEAR]\nExample: #{$0} 1 2025"
  exit 2
end

day = day_arg.to_i
session = ENV['AOC_SESSION'] || ENV['SESSION']
unless session && !session.empty?
  warn "AOC session cookie not found. Set AOC_SESSION in environment or .env file."
  exit 3
end

uri = URI("https://adventofcode.com/#{year}/day/#{day}/input")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
req = Net::HTTP::Get.new(uri.request_uri)
req['Cookie'] = "session=#{session}"
req['User-Agent'] = "ruby-aoc-input-downloader"

res = http.request(req)
case res.code.to_i
when 200
  FileUtils.mkdir_p(File.join(ROOT, 'inputs'))
  filename = File.join(ROOT, 'inputs', format('day-%02d.txt', day))
  File.write(filename, res.body)
  puts "Saved input to #{filename}"
when 404
  warn "Input not available (404). Are you sure the day/year are correct?"
  exit 4
else
  warn "Failed to fetch input: HTTP #{res.code}"
  exit 5
end
