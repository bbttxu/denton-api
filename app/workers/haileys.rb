#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class Haileys < Scraper
  @queue = :haileys

  @shows_urls = "http://smokingmouse.com/haileys/special-events/"

  def self.site
    open( @shows_urls )
  end

  def self.shows
    doc = Nokogiri::HTML(site())
    doc.css("li.gig")
  end

  def self.parseSource(show)
    {
      source: [@shows_urls, show.attr("id")].join('#')
    }
  end

  def self.parseStartsAt(show)
    attribute = show.css('time.datetime').attr('datetime').text
    datetime = attribute.split("T")
    starts_at = Chronic.parse( [datetime[0], datetime[1]].join(" ") ).localtime
    time_is_uncertain = datetime[1].length <= 1 ? true : false
    {
      starts_at: starts_at,
      time_is_uncertain: time_is_uncertain
    }
  end

  def self.parsePrice(show)
    prices = show.css('.entry p')
    prices = prices.collect {|price| price.inner_text }
    # prices = prices.map {|price| price.text}
    prices = prices.select do |price|
      price && price.include?("$")
    end

    price = prices[0] ? prices[0] : "???"
    {
      price: price
    }
  end

  def self.parseArtist(show)
    artist = show.css('span.location')[0].inner_text
    artist = artist.split("–")[0].strip!
    {
      name: artist
    }
  end

  def self.perform()
    puts "updating Hailey's"

    haileys = Venue.find_or_create_by name: "Hailey's Club"
    haileys.phone = "(940) 323-1159"
    haileys.address = "122 Mulberry Street, Denton, TX"
    haileys.save

    current_shows_id = Show.where(:venue => haileys).collect{|x|puts x.id}

    new_show_ids = []

    shows().each do |showHTML|
      show = {}
      show = show.merge parseSource(showHTML)
      show = show.merge parseStartsAt(showHTML)
      show = show.merge parsePrice(showHTML)

      show = Show.find_or_initialize_by show
      show.venue = haileys
      show.save

      gig_ids = show.gigs

      new_show_ids << show.id

      # puts show.to_json

      artist = parseArtist(showHTML)

      full_name = artist[:name].split(/\s/).collect{|x|x.capitalize}
      full_name = full_name.join( " " )

      artist = Artist.find_or_initialize_by name: full_name
      artist.save

      gig = Gig.find_or_initialize_by :position => 1, :artist_id => artist.id, :show_id => show.id
      gig.save


      show.gigs << gig

      show.save
    end

    (current_shows_id - new_show_ids).each do |show_id|
      Show.find(show_id).destroy
    end
  end
end
