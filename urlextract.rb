#!/usr/bin/env -S ruby --disable-gems

trap('SIGINT') { exit 130 }

require 'rubygems'
require 'nokogiri'
require 'addressable/uri'
include Addressable

def eh = abort "Usage: #{$0} base_url < html"
base = URI.parse $*[0] rescue eh
eh unless base&.scheme

Nokogiri::HTML($stdin.read).css('links,a,img,iframe,script,video,audio').each do |n|
  u = URI.parse(n['src'] || n['href']) rescue next
  next if !u || (!u.scheme && u.path.strip == '')
  u.fragment = nil
  puts URI.normalized_encode(u.scheme ? u : base.join(u))
end
