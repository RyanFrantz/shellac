#!/usr/bin/env ruby

#
# Headers - A simple class defining basic attributes and methods for HTTP headers.
#

class Headers
  # Not much here. Instantiate a hash to store HTTP headers.
  def initialize
    @headers = {}
  end

  # Add a header to the @headers hash.
  def add_header(key, value)
    if @headers.has_key?(key)
      # If the value is a string, turn it into an array...
      if @headers[key].is_a?(String)
        previous_value = @headers[key]
        @headers[key] = [previous_value, value]
      # ... else append to the array.
      else
        @headers[key] << value
      end
    else
      @headers[key] = value
    end
  end

  # Return the @headers hash.
  def headers
    @headers
  end

  # If we reach this method, assume we want to find and return a value from
  # the @headers hash using :method as the key name to look up.
  # It's a hack, but this is an MVP.
  def method_missing(method)
    header_name = method.id2name
    header_words = header_name.split('_')
    header_words.each do |word|
      word.capitalize!
    end
    header_name = header_words.join('-')
    if @headers.has_key?(header_name)
      # TODO: Add some color to help visually separate output. It'd be slick
      # if we used a different color based on request/response object.
      #puts "\e[1;33m#{@headers[header_name]}\e[0;0m"
      @headers[header_name]
    end
  end

end
