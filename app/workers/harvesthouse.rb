#!/usr/bin/env ruby -wKU
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'chronic'

# worker to scrape data from the following venue
class HarvestHouse < Scraper
  @queue = :harvesthouse

  @shows_url = "http://www.dentonharvesthouse.com/calendar/"

  def self.site
    open( @shows_url )
  end

  def self.shows
    doc = Nokogiri::HTML(site())
    doc.css(".eventlist-event--upcoming")
  end

  def self.parseSource(show)
    meta = show.css('h1 a')

    source = nil
    if meta[0]
      source = [ "http://www.dentonharvesthouse.com", meta[0]['href'].to_s ].join("")
    end
    {
      source: source
    }
  end

  def self.parseStartsAt(show)
    event = ''
    starts_at = show.css('.event-time-12hr-start')

    time = starts_at.text

    date = show.css('.event-date').attr('datetime')

    # puts time
    # puts date
    # puts [date, time].join(" ")
    # puts Chronic.parse([date, time].join(" "))


    # if starts_at[1]
    #   starts_at = starts_at[1].text.strip!
    #   tokens = starts_at.split ", "

    #   time = tokens.pop
    #   time = time.split('–')[0]

    #   if time
    #     event = "#{tokens[1]} #{tokens[2]} #{time}"
    #   end
    # end
    {
      starts_at: Chronic.parse([date, time].join(" ")),
      time_is_uncertain: false
    }
  end

  def self.parsePrice(show)

  end

  def self.parseArtists(show)
    lineup = show.css('h1 a')
    g = []

    if lineup[0]
      bands = lineup[0].text.split "//"

      g = bands.collect { |band|
        cleansed_band_name = band.downcase
        full_name = cleansed_band_name.split(' ').collect{ | x | x.capitalize}
        full_name = full_name.join( " " )
        { name: full_name }
      }
    end
    g
  end

  def self.perform()
    puts "updating harvesthouse"

    harvesthouse = Venue.find_or_create_by name: "Harvest House"
    harvesthouse.slug = "harvesthouse"
    harvesthouse.phone = "331 E Hickory St, Denton, TX"
    harvesthouse.address = "331 E Hickory St, Denton, TX"
    harvesthouse.save

    current_shows_id = Show.where(:venue => harvesthouse).collect{|x|puts x.id}

    new_show_ids = []


    shows().each do |showHTML|
      # puts showHTML

      show = {}
      show = show.merge parseSource(showHTML)
      show = show.merge parseStartsAt(showHTML)

      show = Show.find_or_initialize_by show

      show.venue = harvesthouse

      show.save

      gig_ids = show.gigs

      new_show_ids << show.id

      artists = parseArtists(showHTML)

      artists.each_with_index { |artist, index|

        artist = Artist.find_or_initialize_by artist

        artist.save

        gig = Gig.find_or_initialize_by :position => index, :artist => artist, :show_id => show.id
        gig.save

        show.gigs << gig

        puts show.to_json
        puts show.errors.to_json

      }

      show.save
    end

    (current_shows_id - new_show_ids).each do |show_id|
      Show.find(show_id).destroy
    end
  end
end
