#!/usr/bin/env ruby

# Get the input argument
input = ARGV[0]

# Define the regular expression to extract the required fields
regex = /from:(.*?)\] \[to:(.*?)\] \[flags:(.*?)\]/

# Find all matches in the input string
matches = input.scan(regex)

# Print the matches in the required format
matches.each do |match|
  puts "#{match[0]},#{match[1]},#{match[2]}"
end
