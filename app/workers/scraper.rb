# worst. name. ever.
require "rubygems"
require "resque"
require 'resque-loner'
require 'cachebar'


class String
	def slugify
		self.strip.gsub(/(.*)(p|P)resents(:?)/, '').downcase.gsub(/\s/,'-').gsub(/[!]/, '').gsub('.','')
	end
end

class Scraper
  include Resque::Plugins::UniqueJob
end