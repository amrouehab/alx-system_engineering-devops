#!/usr/bin/env ruby

# Get the input argument
input = ARGV[0]

# Define the regular expression to match the pattern
regex = /^\d{10}$/

# Find all matches in the input string
matches = input.scan(regex)

# Print the matches
puts matches.join
