#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class Abbey < Scraper
  @queue = :abbey

  @shows_url = "https://www.reverbnation.com/venue/1003284"

  def self.site
    open( @shows_url )
  end

  def self.shows
    doc = Nokogiri::HTML(site())
    doc.css("#shows_container li")
  end

  def self.parseSource(show)
    source = []

    show.css('meta').each do |meta|
      source << meta['content'] if meta['itemprop'] == 'url'
    end

    {
      source: source[0]
    }
  end

  def self.parseStartsAt(show)
    starts_at =  show.css('.details_time').text
    asdf = starts_at.gsub(",","").gsub(/\s/, " ").split(" ")
    event = "#{asdf[1]} #{asdf[2]} #{asdf[5]}"

    {
      starts_at: Chronic.parse(event),
      time_is_uncertain: false
    }
  end

  def self.parsePrice(show)

  end

  def self.parseArtist(show)
    band_name = show.css('h4.show_artist').text.strip
    cleansed_band_name = band_name.downcase
    full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
    full_name = full_name.join( " " )
    {
      name: full_name
    }
  end


  def self.perform()
    # puts "updating Abbey Underground"

    abbey = Venue.find_or_create_by name: "Abbey Underground"
    abbey.slug = "abbey_underground"
    abbey.phone = "(940) 566-5483"
    abbey.address = "101 W Hickory St  Denton, TX 76201"
    abbey.save

    current_shows_id = Show.where(:venue => abbey).collect{|x|puts x.id}

    new_show_ids = []

    shows().each do |showHTML|

      show = {}
      show = show.merge parseSource(showHTML)
      show = show.merge parseStartsAt(showHTML)

      show = Show.find_or_initialize_by show

      show.venue = abbey

      show.save

      gig_ids = show.gigs

      new_show_ids << show.id

      artist = parseArtist(showHTML)

      artist = Artist.find_or_initialize_by artist

      puts artist.errors.to_json

      artist.save

      gig = Gig.find_or_initialize_by :position => 1, :artist => artist, :show_id => show.id

      puts gig.to_json

      gig.save

      show.gigs << gig

      show.save
    end

    (current_shows_id - new_show_ids).each do |show_id|
      Show.find(show_id).destroy
    end
  end
end
