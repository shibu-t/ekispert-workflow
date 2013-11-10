#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "bundle/bundler/setup"
require "alfred"
require "lib/Search"
require "lib/Endpoint"




Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  if (!ARGV[0].nil?)
      from = ARGV[0]
      to = ARGV[1]

      query = ARGV.join(" ").strip

      sta = Search.new(from, to)
      url = sta.main()
      # add an arbitrary feedback
      fb.add_item({
        :uid      => ""                     ,
        :title    => query          ,
        :subtitle => "Enter and Go to site"        ,
        :arg      =>  url,
        :valid    => "yes"                  ,
      })
  end

  puts fb.to_xml(ARGV)
end



