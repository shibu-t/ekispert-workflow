#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "bundle/bundler/setup"
require "alfred"
require "lib/Search"
require "lib/Endpoint"




Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  # add a file feedback
  fb.add_file_item(File.expand_path "~/Applications/")

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
        :subtitle => "feedback item"        ,
        :arg      =>  url,
        :valid    => "yes"                  ,
      })
  end
  
  # add an feedback to test rescue feedback
  fb.add_item({
    :uid          => ""                     ,
    :title        => "Rescue Feedback Test" ,
    :subtitle     => "rescue feedback item" ,
    :arg          => ""                     ,
    :autocomplete => "failed"               ,
    :valid        => "no"                   ,
  })

  if ARGV[0].eql? "failed"
    alfred.with_rescue_feedback = true
    raise Alfred::NoBundleIDError, "Wrong Bundle ID Test!"
  end

  puts fb.to_xml(ARGV)
end



