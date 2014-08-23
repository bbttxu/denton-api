# worst. name. ever.
require "rubygems"
require "resque"
require 'resque-loner'
require 'cachebar'


class String
  def slug
    self.strip.gsub(/(.*)(p|P)resents(:?)/, '').downcase.gsub(/\s/,'-').gsub(/[!]/, '').gsub('.','').gsub("&","and")
  end

  def slugify
    self.strip.gsub(/(.*)(p|P)resents(:?)/, '').downcase.gsub(/\s/,'-').gsub(/[!]/, '').gsub('.','')
  end

  def deslugify
    self.split('-').collect{ | x | x.capitalize}.join(" ")
  end
end

class Scraper
  include Resque::Plugins::UniqueJob

  def slugify(text)
    text.slug
  end
end
